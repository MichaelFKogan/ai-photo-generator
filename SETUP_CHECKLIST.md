# 🚀 Video Generation Setup Checklist

Follow these steps in order to get video generation working:

---

## ✅ Step 1: Run Database Migration

1. Open **Supabase Dashboard** → **SQL Editor**
2. Open the file `SUPABASE_MEDIA_MIGRATION.sql`
3. Copy and paste the entire SQL
4. Click **RUN** ▶️
5. Verify success (should see "Success. No rows returned")

**What this does:**
- Renames `user_images` table to `user_media`
- Adds `media_type` column (image/video)
- Adds `file_extension` column (mp4, jpg, etc.)
- Adds `thumbnail_url` column for video thumbnails

---

## ✅ Step 2: Create Video Storage Bucket

1. Go to **Supabase Dashboard** → **Storage**
2. Click **"New bucket"** button
3. Fill in:
   - **Name**: `user-generated-videos`
   - **Public bucket**: ✅ **CHECK THIS BOX**
   - **File size limit**: Leave default (or increase if needed)
4. Click **"Create bucket"**

---

## ✅ Step 3: Set Storage Policies

### Option A: Using SQL Editor (Recommended)

1. Open **Supabase Dashboard** → **SQL Editor**
2. Open the file `STORAGE_POLICIES.sql`
3. Copy and paste the entire SQL
4. Click **RUN** ▶️
5. Verify success (should create 4 policies)

### Option B: Using Dashboard UI

Go to **Storage** → **Policies** → `user-generated-videos` bucket:

#### Policy 1: Allow authenticated uploads
```
Operation: INSERT
Target roles: authenticated
USING expression: (leave empty)
WITH CHECK expression:
bucket_id = 'user-generated-videos' AND auth.uid()::text = (storage.foldername(name))[1]
```

#### Policy 2: Allow public reads
```
Operation: SELECT
Target roles: public
USING expression:
bucket_id = 'user-generated-videos'
WITH CHECK expression: (leave empty)
```

#### Policy 3: Allow users to update own videos
```
Operation: UPDATE
Target roles: authenticated
USING expression:
bucket_id = 'user-generated-videos' AND auth.uid()::text = (storage.foldername(name))[1]
WITH CHECK expression:
bucket_id = 'user-generated-videos' AND auth.uid()::text = (storage.foldername(name))[1]
```

#### Policy 4: Allow users to delete own videos
```
Operation: DELETE
Target roles: authenticated
USING expression:
bucket_id = 'user-generated-videos' AND auth.uid()::text = (storage.foldername(name))[1]
WITH CHECK expression: (leave empty)
```

---

## ✅ Step 4: Verify Setup

Run this SQL to check everything is configured:

```sql
-- Check table was renamed and columns added
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'user_media';

-- Should see: media_type, file_extension, thumbnail_url

-- Check storage bucket exists
SELECT * FROM storage.buckets WHERE name = 'user-generated-videos';

-- Check policies are set
SELECT policyname, cmd 
FROM pg_policies 
WHERE tablename = 'objects' 
AND policyname LIKE '%videos%';

-- Should see 4 policies: INSERT, SELECT, UPDATE, DELETE
```

---

## ✅ Step 5: Test Video Generation

1. **Run your app**
2. **Navigate to any video detail view**
3. **Select a photo**
4. **Tap "Generate Video"**
5. **Watch the console logs:**

You should see:
```
[WaveSpeed] Job created, polling for completion…
[WaveSpeed] Will poll up to 120 times (every 5 seconds = 600s max)
[WaveSpeed] Polling attempt 1/120...
[WaveSpeed] Polling attempt 2/120...
...
[WaveSpeed] Job completed successfully!
[Storage] Video downloaded, size: X bytes
[Storage] Uploading thumbnail...
✅ Thumbnail uploaded
[Storage] Uploading video to: user-generated-videos/...
[Storage] Video size: X MB
[Storage] Video upload successful
✅ Video metadata saved to database
```

6. **Check Profile tab** - Video should appear with play icon
7. **Tap video** - Should play full-screen

---

## 🐛 Troubleshooting

### ❌ Error: "new row violates row-level security policy"

**Problem:** Storage policies not set correctly

**Solution:**
1. Go to **Storage** → **Policies** → `user-generated-videos`
2. Delete all existing policies
3. Re-run `STORAGE_POLICIES.sql` from SQL Editor

### ❌ Error: "The request timed out"

**Problem:** Thumbnail upload timeout (network issue)

**Solution:** This is now non-blocking! The video will still upload even if thumbnail fails. You can:
- Check your internet connection
- Try again (retry logic will help)
- Video will work without thumbnail (shows play icon instead)

### ❌ Error: "relation user_images does not exist"

**Problem:** Migration didn't run or table wasn't renamed

**Solution:**
1. Check if table was renamed: `SELECT * FROM user_media LIMIT 1;`
2. If error, table wasn't renamed - run migration again
3. Or manually rename: `ALTER TABLE user_images RENAME TO user_media;`

### ❌ Video not appearing in Profile

**Problem:** Database query might be using old table name

**Solution:**
1. Check ProfileViewModel is querying `user_media` not `user_images`
2. Force refresh Profile view (pull down)
3. Check console for database errors

### ❌ Polling timeout after 10 minutes

**Problem:** Video generation taking too long from API

**Solution:**
- This is expected for complex videos
- Try with a simpler/shorter video
- Check WaveSpeed API status
- Consider increasing polling attempts in code

---

## 📊 What's Configured

After completing all steps, you should have:

✅ **Database:**
- `user_media` table with new columns
- Supports both images and videos

✅ **Storage:**
- `user-generated-images` bucket (for images + thumbnails)
- `user-generated-videos` bucket (for videos)
- RLS policies for secure access

✅ **Code:**
- Video generation pipeline
- Thumbnail generation
- Retry logic for uploads
- Extended polling timeout (10 minutes)
- Non-blocking thumbnail uploads

---

## 🎯 Expected Behavior

### Video Generation Flow:
1. User selects photo
2. Taps "Generate Video"
3. Notification shows progress
4. Polls API every 5 seconds (up to 10 minutes)
5. Downloads video (~1-2 MB)
6. Generates thumbnail from first frame
7. Uploads thumbnail (with retry, non-blocking)
8. Uploads video (with retry)
9. Saves metadata to database
10. Shows in Profile automatically

### Profile Display:
- Videos show with play icon overlay
- Tap to play full-screen
- Works even without thumbnail
- Can download, share, delete

---

## 📝 Files Reference

- **SUPABASE_MEDIA_MIGRATION.sql** - Database changes
- **STORAGE_POLICIES.sql** - Storage security policies
- **VIDEO_GENERATION_SETUP_GUIDE.md** - Full documentation
- **VIDEO_QUICK_REFERENCE.md** - Quick reference card

---

## ✨ Success Indicators

You'll know it's working when you see:

1. ✅ Video generates without timeout
2. ✅ Video appears in Profile with play icon
3. ✅ Can play video full-screen
4. ✅ Can download to Photos
5. ✅ Can share video
6. ✅ Can delete video
7. ✅ No 403 errors in console
8. ✅ Polling completes successfully

---

## 🆘 Still Having Issues?

Check these common mistakes:

- [ ] Did you make the bucket **PUBLIC**? (Critical!)
- [ ] Did you run **ALL 4 policies** for videos bucket?
- [ ] Is the user **authenticated** when uploading?
- [ ] Did the **table rename** succeed?
- [ ] Are you on a **stable network connection**?
- [ ] Did you **restart the app** after changes?

---

**🎉 Once all steps are complete, you're ready to generate videos!**

