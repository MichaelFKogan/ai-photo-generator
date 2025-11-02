-- ========================================
-- Debug: Check Video Bucket Setup
-- Run each section and check the results
-- ========================================

-- 1. Check if the bucket exists
SELECT id, name, public, file_size_limit, allowed_mime_types
FROM storage.buckets 
WHERE name = 'user-generated-videos';

-- Expected: Should return 1 row with name = 'user-generated-videos' and public = true
-- If empty: Bucket doesn't exist - create it in Storage UI
-- If public = false: Make it public in Storage settings


-- 2. Check what policies exist for this bucket
SELECT 
    policyname,
    cmd as operation,
    roles,
    qual as using_expression,
    with_check
FROM pg_policies 
WHERE tablename = 'objects' 
AND (
    policyname LIKE '%video%' 
    OR qual::text LIKE '%user-generated-videos%'
    OR with_check::text LIKE '%user-generated-videos%'
)
ORDER BY cmd;

-- Expected: Should return 4 rows (INSERT, SELECT, UPDATE, DELETE)
-- If empty: No policies set - run STORAGE_POLICIES.sql
-- If < 4 rows: Some policies missing


-- 3. Check if there are ANY policies blocking access
SELECT 
    policyname,
    cmd,
    roles
FROM pg_policies 
WHERE tablename = 'objects'
ORDER BY policyname;

-- This shows ALL storage policies
-- Look for any that might be blocking video bucket access


-- 4. Try to see current user ID (for debugging)
SELECT auth.uid() as current_user_id;

-- This shows the authenticated user's UUID
-- Should match the folder name in your upload path


-- ========================================
-- If checks show missing policies, run this:
-- ========================================

-- Delete any existing video policies first (clean slate)
DROP POLICY IF EXISTS "Allow authenticated uploads to videos bucket" ON storage.objects;
DROP POLICY IF EXISTS "Allow public read access to videos" ON storage.objects;
DROP POLICY IF EXISTS "Allow users to update own videos" ON storage.objects;
DROP POLICY IF EXISTS "Allow users to delete own videos" ON storage.objects;

-- Now create fresh policies
CREATE POLICY "Allow authenticated uploads to videos bucket"
ON storage.objects 
FOR INSERT 
TO authenticated
WITH CHECK (
    bucket_id = 'user-generated-videos' 
    AND auth.uid()::text = (storage.foldername(name))[1]
);

CREATE POLICY "Allow public read access to videos"
ON storage.objects 
FOR SELECT 
TO public
USING (bucket_id = 'user-generated-videos');

CREATE POLICY "Allow users to update own videos"
ON storage.objects 
FOR UPDATE 
TO authenticated
USING (
    bucket_id = 'user-generated-videos' 
    AND auth.uid()::text = (storage.foldername(name))[1]
)
WITH CHECK (
    bucket_id = 'user-generated-videos' 
    AND auth.uid()::text = (storage.foldername(name))[1]
);

CREATE POLICY "Allow users to delete own videos"
ON storage.objects 
FOR DELETE 
TO authenticated
USING (
    bucket_id = 'user-generated-videos' 
    AND auth.uid()::text = (storage.foldername(name))[1]
);

-- Verify policies were created
SELECT policyname, cmd 
FROM pg_policies 
WHERE tablename = 'objects' 
AND policyname LIKE '%videos%'
ORDER BY cmd;

-- Should now show 4 policies!

