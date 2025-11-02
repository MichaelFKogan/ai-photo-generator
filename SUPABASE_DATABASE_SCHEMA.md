# Supabase Database Schema Update

## Overview
Your app now stores additional metadata (title, cost, type, endpoint) alongside the image URLs. This document explains the required database changes.

---

## Required: Update `user_images` Table

### Step 1: Go to Supabase SQL Editor
1. Visit [https://supabase.com/dashboard](https://supabase.com/dashboard)
2. Select your project: **inaffymocuppuddsewyq**
3. Click **SQL Editor** in the left sidebar

### Step 2: Add New Columns

Run this SQL to add the new columns to your `user_images` table:

```sql
-- Add new columns for image metadata
ALTER TABLE user_images
ADD COLUMN IF NOT EXISTS title TEXT,
ADD COLUMN IF NOT EXISTS cost NUMERIC(10, 2),
ADD COLUMN IF NOT EXISTS type TEXT,
ADD COLUMN IF NOT EXISTS endpoint TEXT;
```

### Step 3: Verify Table Structure

Run this query to verify your table now has all the required columns:

```sql
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = 'user_images'
ORDER BY ordinal_position;
```

**Expected columns:**
- `id` (integer or bigint) - Primary key
- `created_at` (timestamp) - Auto-generated
- `user_id` (text or uuid)
- `image_url` (text) - **Now stores Supabase Storage URL**
- `model` (text) - AI model name (optional)
- `title` (text) - **NEW** - Filter/effect title (optional)
- `cost` (numeric) - **NEW** - Generation cost (optional)
- `type` (text) - **NEW** - "Photo Filter", "Video", etc. (optional)
- `endpoint` (text) - **NEW** - API endpoint used (optional)

---

## How It Works Now

### Data Saved During Generation:

When a user generates an image, the following data is saved:

```swift
{
  "user_id": "abc123...",
  "image_url": "https://...supabase.co/storage/.../user_id/timestamp_model.jpg",
  "model": "anime-style",       // Only if not empty
  "title": "Anime",             // Only if not empty
  "cost": 0.04,                 // Only if > 0
  "type": "Photo Filter",       // Only if not empty
  "endpoint": "https://api..."  // Only if not empty
}
```

### Display Logic:

**For "Photo Filter" type:**
- ✅ Shows title with paintbrush icon
- ✅ Shows type and cost
- ✅ Shows model (if available)
- ✅ Shows "Reuse This Filter" button

**For other types:**
- Shows generic "AI Generated" label
- Shows model name (if available)
- No "Reuse" button

---

## Migration Note

### Existing Records
Old records without the new fields will continue to work:
- They'll display in the grid normally
- Full screen view will show minimal info
- No errors will occur (all new fields are optional)

### Clean Slate Option
If you deleted your old WaveSpeed URL records (as discussed), all new images will have the complete metadata from the start.

---

## Optional: Add Database Indexes

For better query performance as your user base grows:

```sql
-- Index on user_id for faster user image queries
CREATE INDEX IF NOT EXISTS idx_user_images_user_id 
ON user_images(user_id);

-- Index on type for filtering by image type
CREATE INDEX IF NOT EXISTS idx_user_images_type 
ON user_images(type);

-- Index on created_at for chronological ordering
CREATE INDEX IF NOT EXISTS idx_user_images_created_at 
ON user_images(created_at DESC);
```

---

## Testing Checklist

After making these changes:

1. ✅ Generate a new image from a Photo Filter
2. ✅ Check console logs for: `📝 Saving metadata: ...`
3. ✅ Verify image appears in Profile view
4. ✅ Tap image to open full screen
5. ✅ Verify metadata displays:
   - Title (e.g., "Anime")
   - Type ("Photo Filter")
   - Cost (e.g., "$0.04")
6. ✅ Verify "Reuse This Filter" button appears

---

## Future Enhancements

As you mentioned, you'll eventually add more fields. The system is now set up to easily expand:

**Potential Future Fields:**
- `description` - Longer description of the effect
- `prompt` - The AI prompt used
- `aspect_ratio` - Image dimensions
- `output_format` - JPEG, PNG, etc.
- `duration` - For videos
- `thumbnail_url` - Smaller preview image

Just add these columns when needed using `ALTER TABLE` and update the `UserImage` struct in `ProfileViewModel.swift`.

---

## Troubleshooting

### Error: "column does not exist"
- Make sure you ran the `ALTER TABLE` SQL
- Check column names match exactly (case-sensitive)
- Restart your app after database changes

### Fields not saving
- Check console logs for `📝 Saving metadata`
- Verify the InfoPacket has the fields populated
- Check Supabase logs for insert errors

### Old images showing empty metadata
- This is expected for images generated before the update
- Only new images will have complete metadata
- Consider deleting old test images if needed

