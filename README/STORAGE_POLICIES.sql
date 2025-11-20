-- ========================================
-- Storage Policies for user-generated-videos
-- Run these in Supabase SQL Editor
-- ========================================

-- 1. Allow authenticated users to INSERT (upload) their own videos
CREATE POLICY "Allow authenticated uploads to videos bucket"
ON storage.objects
FOR INSERT
TO authenticated
WITH CHECK (
    bucket_id = 'user-generated-videos' 
    AND auth.uid()::text = (storage.foldername(name))[1]
);

-- 2. Allow public SELECT (read) access to all videos
CREATE POLICY "Allow public read access to videos"
ON storage.objects
FOR SELECT
TO public
USING (bucket_id = 'user-generated-videos');

-- 3. Allow authenticated users to UPDATE their own videos
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

-- 4. Allow authenticated users to DELETE their own videos
CREATE POLICY "Allow users to delete own videos"
ON storage.objects
FOR DELETE
TO authenticated
USING (
    bucket_id = 'user-generated-videos' 
    AND auth.uid()::text = (storage.foldername(name))[1]
);

-- ========================================
-- Verify policies are created
-- ========================================
SELECT 
    policyname, 
    cmd, 
    qual,
    with_check
FROM pg_policies 
WHERE tablename = 'objects' 
AND policyname LIKE '%videos%';

