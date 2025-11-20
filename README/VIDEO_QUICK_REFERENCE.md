# Video Generation - Quick Reference Card

## 🎯 Quick Setup (3 Steps)

### Step 1: Database
```sql
-- Run in Supabase SQL Editor
ALTER TABLE user_images 
ADD COLUMN media_type TEXT DEFAULT 'image',
ADD COLUMN file_extension TEXT DEFAULT 'jpg',
ADD COLUMN thumbnail_url TEXT;
```

### Step 2: Storage
1. Create bucket: `user-generated-videos` (public)
2. Add policies (see full guide)

### Step 3: Test
1. Use VideoConfirmationView
2. Generate a video
3. Check Profile tab

---

## 📋 File Changes Summary

| File | Changes | Status |
|------|---------|--------|
| `NotificationManager.swift` | + VideoMetadata, + startBackgroundVideoGeneration() | ✅ Complete |
| `SupabaseManager.swift` | + uploadVideo(), + generateVideoThumbnail() | ✅ Complete |
| `ProfileViewModel.swift` | Extended UserImage with video fields | ✅ Complete |
| `5-ProfileView.swift` | + Video player, + play icons, + download | ✅ Complete |
| `VideoConfirmationView.swift` | Changed to video generation | ✅ Complete |

---

## 🎬 Video Generation Flow

```
┌─────────────────────────────────────────────────────────────────┐
│  1. User Selects Photo in VideoDetailView                      │
│     ↓                                                           │
│  2. Navigates to VideoConfirmationView                         │
│     ↓                                                           │
│  3. Taps "Generate Video" Button                               │
│     ↓                                                           │
│  4. notificationManager.startBackgroundVideoGeneration()       │
│     ├─ Shows progress notification                             │
│     ├─ Uploads photo to WaveSpeed API                          │
│     ├─ Downloads generated video                               │
│     ├─ Generates thumbnail from video                          │
│     ├─ Uploads video to user-generated-videos bucket           │
│     ├─ Uploads thumbnail to user-generated-images bucket       │
│     └─ Saves metadata to database                              │
│     ↓                                                           │
│  5. Video appears in Profile automatically                      │
│     ↓                                                           │
│  6. User can play, download, share, or delete                  │
└─────────────────────────────────────────────────────────────────┘
```

---

## 🗂️ Data Structure

### UserImage Model (Extended)
```swift
struct UserImage {
    let id: String
    let image_url: String        // Video URL for videos
    let media_type: String?      // "image" or "video"
    let file_extension: String?  // "mp4", "jpg", etc.
    let thumbnail_url: String?   // Thumbnail URL for videos
    // ... existing fields
    
    var isVideo: Bool            // Computed property
    var isImage: Bool            // Computed property
}
```

### Storage Buckets
```
📦 user-generated-images/
   └── {userId}/
       ├── {timestamp}_{model}.jpg (images)
       └── {timestamp}_{model}_thumbnail.jpg (video thumbnails)

📦 user-generated-videos/
   └── {userId}/
       └── {timestamp}_{model}.mp4 (videos)
```

---

## 🎮 Key Functions

### Generate Video
```swift
let taskId = notificationManager.startBackgroundVideoGeneration(
    item: item,
    image: image,
    userId: userId,
    onVideoGenerated: { videoUrl in
        print("Video ready: \(videoUrl)")
    }
)
```

### Upload Video
```swift
let videoUrl = try await SupabaseManager.shared.uploadVideo(
    videoData: videoData,
    userId: userId,
    modelName: modelName,
    fileExtension: "mp4"
)
```

### Generate Thumbnail
```swift
let thumbnail = await SupabaseManager.shared.generateVideoThumbnail(
    from: videoData
)
```

---

## 🎨 UI Components

### Profile Grid
- Shows video thumbnails
- Play icon overlay on videos
- Same aspect ratio as images (1:1.4)

### Full Screen View
- AVKit video player for videos
- Pinch-to-zoom for images
- Download, share, delete actions
- Media type badge

---

## 🐛 Troubleshooting Quick Fixes

| Problem | Solution |
|---------|----------|
| Video not in Profile | Run database migration |
| Upload fails | Create video storage bucket |
| No thumbnail | Normal for some formats, shows play icon |
| Won't play | Check video format supported by iOS |
| Generation timeout | Videos take up to 10 minutes |

---

## 📊 Supported Formats

| Format | Extension | MIME Type | Status |
|--------|-----------|-----------|--------|
| MP4 | .mp4 | video/mp4 | ✅ Supported |
| WebM | .webm | video/webm | ✅ Supported |
| MOV | .mov | video/quicktime | ✅ Supported |
| AVI | .avi | video/x-msvideo | ✅ Supported |

---

## ⚡ Performance Notes

- **Image Generation**: Up to 5 minutes (60 polls × 5s)
- **Video Generation**: Up to 10 minutes (120 polls × 5s)
- **Polling Interval**: Every 5 seconds
- **Thumbnail Generation**: < 1 second
- **Upload Speed**: Depends on file size and network
- **Background Processing**: Continues even if app backgrounded

---

## 🔐 Storage Policies Required

```sql
-- Allow authenticated uploads
CREATE POLICY "Allow authenticated uploads"
ON storage.objects FOR INSERT TO authenticated
WITH CHECK (bucket_id = 'user-generated-videos');

-- Allow public reads
CREATE POLICY "Allow public access"
ON storage.objects FOR SELECT TO public
USING (bucket_id = 'user-generated-videos');

-- Allow users to delete their own
CREATE POLICY "Allow users to delete own"
ON storage.objects FOR DELETE TO authenticated
USING (bucket_id = 'user-generated-videos' 
       AND auth.uid()::text = (storage.foldername(name))[1]);
```

---

## ✅ Testing Checklist

- [ ] SQL migration executed
- [ ] Video bucket created
- [ ] Storage policies added
- [ ] Generate test video
- [ ] Video shows in Profile
- [ ] Play icon appears
- [ ] Full-screen playback works
- [ ] Download to Photos works
- [ ] Share works
- [ ] Delete removes video + thumbnail

---

## 📞 Quick Help

**Check logs for:**
- `[WaveSpeed]` - API calls
- `[Storage]` - Upload/download
- `✅` - Success
- `❌` - Errors

**Console commands:**
```swift
// Check video count
print(viewModel.userImages.filter { $0.isVideo }.count)

// Check if thumbnail exists
print(userImage.thumbnail_url ?? "No thumbnail")

// Check media type
print(userImage.media_type ?? "Not set")
```

---

## 🚀 You're Ready!

1. ✅ Database extended
2. ✅ Video upload implemented
3. ✅ UI updated for video playback
4. ✅ Thumbnail generation working
5. ✅ Background processing enabled

**Just run the SQL migration and create the storage bucket!**

---

📚 **Full Documentation**: See `VIDEO_GENERATION_SETUP_GUIDE.md`

