# ⚡ Quick Fix Guide - 403 Error

## The Problem
```
❌ StorageError(statusCode: "403")
❌ "new row violates row-level security policy"
❌ "Unauthorized"
```

## The Fix (2 minutes)

### 1️⃣ Open Supabase Dashboard
Go to: https://supabase.com/dashboard

### 2️⃣ Open SQL Editor
Click: **SQL Editor** in left sidebar

### 3️⃣ Run This SQL
Copy and paste this entire block, then click **RUN**:

```sql
-- Allow authenticated uploads
CREATE POLICY "Allow authenticated uploads to videos bucket"
ON storage.objects FOR INSERT TO authenticated
WITH CHECK (
    bucket_id = 'user-generated-videos' 
    AND auth.uid()::text = (storage.foldername(name))[1]
);

-- Allow public reads
CREATE POLICY "Allow public read access to videos"
ON storage.objects FOR SELECT TO public
USING (bucket_id = 'user-generated-videos');

-- Allow updates
CREATE POLICY "Allow users to update own videos"
ON storage.objects FOR UPDATE TO authenticated
USING (
    bucket_id = 'user-generated-videos' 
    AND auth.uid()::text = (storage.foldername(name))[1]
)
WITH CHECK (
    bucket_id = 'user-generated-videos' 
    AND auth.uid()::text = (storage.foldername(name))[1]
);

-- Allow deletes
CREATE POLICY "Allow users to delete own videos"
ON storage.objects FOR DELETE TO authenticated
USING (
    bucket_id = 'user-generated-videos' 
    AND auth.uid()::text = (storage.foldername(name))[1]
);
```

### 4️⃣ Verify Success
Should see: **"Success. No rows returned"**

### 5️⃣ Test Again
Generate a video in your app!

---

## ✅ That's It!

The 403 error should be gone. Your app will now:
- ✅ Upload videos successfully
- ✅ Retry automatically on timeout
- ✅ Continue even if thumbnail fails
- ✅ Show videos in Profile

---

## 🔍 Quick Check

Run this to verify policies are set:
```sql
SELECT policyname 
FROM pg_policies 
WHERE tablename = 'objects' 
AND policyname LIKE '%videos%';
```

Should show 4 policies.

---

## 🆘 Still Not Working?

### Make sure bucket is PUBLIC:
1. Go to **Storage** → **user-generated-videos**
2. Settings → Public bucket: **ON** ✅

### Make sure user is authenticated:
Check console for: `userId: "SOME-UUID-HERE"`
If shows empty or nil, user isn't logged in.

### Check bucket exists:
```sql
SELECT * FROM storage.buckets 
WHERE name = 'user-generated-videos';
```

Should return one row.

---

## 📚 More Help

- Full setup: `SETUP_CHECKLIST.md`
- All fixes: `ERROR_FIXES_SUMMARY.md`
- Complete guide: `VIDEO_GENERATION_SETUP_GUIDE.md`

---

**Just run the SQL above and you're good to go!** 🚀

