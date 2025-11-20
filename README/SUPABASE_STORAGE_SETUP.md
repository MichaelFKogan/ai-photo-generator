# Supabase Storage Setup Guide

## Overview
Your app now stores generated images directly in Supabase Storage instead of relying on external URLs. This ensures better reliability and control over your image assets.

## What Changed

### 1. **SupabaseManager.swift**
- Added `uploadImage()` method to upload UIImage to Supabase Storage
- Added `downloadAndUploadImage()` helper method
- Images are organized by user ID: `userId/timestamp_modelName.jpg`

### 2. **NotificationManager.swift**
- After downloading image from WaveSpeed API, it now uploads to Supabase Storage
- Database stores Supabase Storage URL instead of WaveSpeed URL
- Added progress update: "Uploading to storage..."

### 3. **ProfileViewModel.swift & ProfileView.swift**
- No changes needed! They continue to fetch and display image URLs
- The URLs now point to Supabase Storage instead of WaveSpeed

---

## Required: Create Storage Bucket in Supabase

You need to create a storage bucket in your Supabase project. Follow these steps:

### Step 1: Go to Supabase Dashboard
1. Visit [https://supabase.com/dashboard](https://supabase.com/dashboard)
2. Select your project: **inaffymocuppuddsewyq**

### Step 2: Create Storage Bucket
1. Click on **Storage** in the left sidebar
2. Click **"New bucket"** button
3. Enter the following details:
   - **Name:** `user-generated-images`
   - **Public:** Toggle ON (images need to be publicly accessible)
   - Click **"Create bucket"**

### Step 3: Set Bucket Policies (Important!)
For public access to images, you need to set up proper policies:

1. In the Storage section, click on your `user-generated-images` bucket
2. Go to **"Policies"** tab
3. Click **"New Policy"**
4. Select **"For full customization"**

**Policy for Public Read Access:**
```sql
CREATE POLICY "Public Read Access"
ON storage.objects FOR SELECT
TO public
USING (bucket_id = 'user-generated-images');
```

**Policy for Authenticated Upload:**
```sql
CREATE POLICY "Authenticated users can upload"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (bucket_id = 'user-generated-images');
```

**Alternative: Use Policy Templates**
- If available, you can use the "Public access" template which automatically creates the necessary policies

### Step 4: Test the Setup
1. Run your app
2. Generate an image
3. Check the console logs for:
   - `[Storage] Uploading image to: user-generated-images/...`
   - `[Storage] Upload successful`
   - `[Storage] Public URL: https://...`
4. Verify the image appears in your Profile view

---

## File Structure in Storage

Images are organized as follows:
```
user-generated-images/
├── {userId1}/
│   ├── 1730000000_anime-style.jpg
│   ├── 1730000123_cyberpunk.jpg
│   └── ...
├── {userId2}/
│   ├── 1730000456_realistic.jpg
│   └── ...
└── ...
```

This organization:
- ✅ Keeps each user's images separate
- ✅ Makes it easy to delete a user's images
- ✅ Provides chronological ordering via timestamp
- ✅ Includes model name for reference

---

## Benefits of This Approach

1. **Reliability**: Images are permanently stored in your Supabase project
2. **Control**: You own the images and can manage storage costs
3. **Performance**: Supabase CDN provides fast image delivery
4. **Privacy**: You can implement fine-grained access controls
5. **Offline Support**: Images can be cached more reliably
6. **No External Dependencies**: Not relying on WaveSpeed URLs that might expire

---

## Troubleshooting

### Error: "Bucket not found"
- Make sure you created the bucket named exactly `user-generated-images`
- Check the bucket name in SupabaseManager.swift matches

### Error: "Permission denied"
- Ensure you set up the storage policies correctly
- For testing, you can temporarily make the bucket fully public

### Error: "File already exists"
- The code uses timestamps to ensure unique filenames
- If this happens, check if the device clock is correct

### Images not showing in Profile
- Check console logs for the storage URL format
- Verify the URLs in your database start with your Supabase URL
- Test by opening the URL in a browser

---

## Optional: Configure Storage Size Limits

In your Supabase dashboard, you can set:
- Maximum file size per upload
- Total storage quota
- File type restrictions

---

## Migration Note

**Important**: If you already have images stored with WaveSpeed URLs in your database, those will still work. Only NEW images will be stored in Supabase Storage.

To migrate existing images (optional):
1. Fetch all existing WaveSpeed URLs from database
2. Use `downloadAndUploadImage()` method to re-upload them
3. Update database records with new Supabase Storage URLs

This can be done with a one-time migration script if needed.

