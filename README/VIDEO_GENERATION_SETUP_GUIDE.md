# Video Generation Setup Guide

This guide explains how to set up video generation alongside your existing image generation functionality.

## 📋 Overview

Your app now supports both **image** and **video** generation using the WaveSpeed API. Videos are stored in a separate Supabase storage bucket and displayed alongside images in the Profile View.

---

## 🗄️ Step 1: Database Migration

### Run the SQL Migration

1. Open your Supabase Dashboard
2. Navigate to **SQL Editor**
3. Open the file `SUPABASE_MEDIA_MIGRATION.sql` (located in your project root)
4. Copy and paste the SQL into the editor
5. Click **Run** to execute the migration

The migration adds these columns to your `user_images` table:
- `media_type` (TEXT) - Either "image" or "video"
- `file_extension` (TEXT) - File extension (e.g., "jpg", "mp4", "webm")
- `thumbnail_url` (TEXT) - Optional thumbnail URL for videos

---

## 📦 Step 2: Create Storage Bucket

### Create the Video Storage Bucket

1. In your Supabase Dashboard, go to **Storage**
2. Click **Create a new bucket**
3. Name it: `user-generated-videos`
4. Set it to **Public** (same as your images bucket)
5. Click **Create**

### Configure Storage Policies

For the `user-generated-videos` bucket, add these policies:

**1. Allow authenticated uploads:**
```sql
CREATE POLICY "Allow authenticated uploads"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (bucket_id = 'user-generated-videos');
```

**2. Allow public access:**
```sql
CREATE POLICY "Allow public access"
ON storage.objects FOR SELECT
TO public
USING (bucket_id = 'user-generated-videos');
```

**3. Allow users to delete their own videos:**
```sql
CREATE POLICY "Allow users to delete own videos"
ON storage.objects FOR DELETE
TO authenticated
USING (bucket_id = 'user-generated-videos' AND auth.uid()::text = (storage.foldername(name))[1]);
```

---

## 🎬 Step 3: Using Video Generation

### In VideoConfirmationView

The `VideoConfirmationView` is now configured to generate videos instead of images. When the user taps "Generate Video":

```swift
notificationManager.startBackgroundVideoGeneration(
    item: item,
    image: image,
    userId: authViewModel.user?.id.uuidString ?? "",
    onVideoGenerated: { videoUrl in
        print("✅ Video generated: \(videoUrl)")
    }
)
```

### Video Generation Process

1. **Upload** - User's photo is sent to WaveSpeed API
2. **Download** - Generated video is downloaded from WaveSpeed
3. **Thumbnail** - A thumbnail is automatically generated from the first frame
4. **Upload to Supabase** - Video and thumbnail are uploaded to storage
5. **Save Metadata** - Video info is saved to database with `media_type = "video"`
6. **Notification** - User sees progress notifications throughout

### Supported Video Formats

The system automatically detects and handles:
- MP4 (default)
- WebM
- MOV
- AVI

---

## 👀 Step 4: Viewing Videos in Profile

### Grid Display

Videos appear in the profile grid with:
- **Thumbnail image** (if available)
- **Play icon overlay** - Indicates it's a video
- Same aspect ratio as images (1:1.4 portrait)

### Full Screen Playback

When a user taps a video:
- **Video Player** - Native AVKit player with controls
- **Auto-play** - Video starts playing automatically
- **Media Badge** - Shows "Video" badge with file extension
- **Download** - Can save video to Photos library
- **Share** - Can share video URL
- **Delete** - Deletes video and thumbnail from storage

---

## 🔧 Technical Details

### Data Models

**UserImage (extends to support videos):**
```swift
struct UserImage: Codable, Identifiable {
    let id: String
    let image_url: String         // Video URL for videos
    let media_type: String?       // "image" or "video"
    let file_extension: String?   // "mp4", "webm", etc.
    let thumbnail_url: String?    // Thumbnail for videos
    // ... other fields
    
    var isVideo: Bool {
        media_type == "video"
    }
}
```

**VideoMetadata:**
```swift
struct VideoMetadata: Encodable {
    let user_id: String
    let image_url: String          // Video URL
    let thumbnail_url: String?     // Thumbnail URL
    let media_type: String         // "video"
    let file_extension: String     // "mp4"
    // ... other fields
}
```

### Key Functions

**NotificationManager:**
- `startBackgroundVideoGeneration()` - Generates videos with progress tracking
- Handles video download, thumbnail generation, and storage upload
- 10-minute timeout for video generation (vs 6 minutes for images)

**SupabaseManager:**
- `uploadVideo()` - Uploads video data to storage
- `downloadAndUploadVideo()` - Downloads from URL and uploads to storage
- `generateVideoThumbnail()` - Creates thumbnail from video

**ProfileView:**
- Shows videos with play icon overlay
- Displays thumbnails in grid
- Full-screen video player with AVKit

---

## 🎯 Testing Checklist

- [ ] Database migration completed
- [ ] `user-generated-videos` bucket created
- [ ] Storage policies configured
- [ ] Generate a test video from VideoConfirmationView
- [ ] Verify video appears in Profile with play icon
- [ ] Tap video to open full-screen player
- [ ] Test video playback controls
- [ ] Download video to Photos library
- [ ] Share video
- [ ] Delete video (check storage and database)

---

## 🐛 Troubleshooting

### Video not appearing in Profile
- Check database migration ran successfully
- Verify `media_type` column exists
- Check that video was saved with `media_type = "video"`

### Thumbnail not showing
- Thumbnail generation may fail for some video formats
- Falls back to video URL with play icon overlay
- Check console logs for thumbnail generation errors

### Upload fails
- Verify `user-generated-videos` bucket exists
- Check storage policies allow uploads
- Ensure user is authenticated
- Check video file size (Supabase has limits)

### Video won't play
- Check video URL is accessible
- Verify video format is supported by iOS
- Check console for AVPlayer errors
- Try downloading and playing locally

---

## 📊 Database Query Examples

**Get all videos for a user:**
```sql
SELECT * FROM user_images 
WHERE user_id = 'USER_ID' 
AND media_type = 'video'
ORDER BY created_at DESC;
```

**Get all media (images and videos):**
```sql
SELECT * FROM user_images 
WHERE user_id = 'USER_ID'
ORDER BY created_at DESC;
```

**Count videos by format:**
```sql
SELECT file_extension, COUNT(*) 
FROM user_images 
WHERE media_type = 'video'
GROUP BY file_extension;
```

---

## 🚀 Future Enhancements

Consider these future improvements:

1. **Video Compression** - Compress videos before upload to save storage
2. **Progress Bar** - Show video playback progress in grid thumbnails
3. **Batch Operations** - Select and delete multiple videos
4. **Filters** - Filter profile view by media type
5. **Video Preview** - Hover to play video preview in grid
6. **Cloud Processing** - Generate thumbnails server-side
7. **Video Trimming** - Allow users to trim videos before generation
8. **Multiple Formats** - Let users choose output format

---

## 📝 Notes

- Videos use the same `user_images` table as images for simplicity
- The column is still named `image_url` but contains video URLs for videos
- Thumbnails are stored in the same bucket as images (`user-generated-images`)
- Video generation takes longer than images (up to 10 minutes)
- Background tasks continue even if user leaves the app

---

## ✅ What's Changed

### New Files
- `SUPABASE_MEDIA_MIGRATION.sql` - Database migration script
- `VIDEO_GENERATION_SETUP_GUIDE.md` - This guide

### Modified Files
- `NotificationManager.swift` - Added `VideoMetadata` and `startBackgroundVideoGeneration()`
- `SupabaseManager.swift` - Added video upload and thumbnail generation
- `ProfileViewModel.swift` - Extended `UserImage` to support videos
- `5-ProfileView.swift` - Added video indicators and playback
- `VideoConfirmationView.swift` - Uses video generation instead of image

### Key Features
✅ Video generation with WaveSpeed API
✅ Automatic thumbnail generation
✅ Separate video storage bucket
✅ Video playback in profile
✅ Download videos to Photos
✅ Share videos
✅ Delete videos and thumbnails
✅ Progress notifications
✅ Multi-format support (mp4, webm, mov, avi)

---

**🎉 You're all set!** Your app now supports both image and video generation with a unified profile view.

