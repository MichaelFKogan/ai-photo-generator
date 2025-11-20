-- Migration: Extend user_images table to support both images and videos
-- This adds support for videos while maintaining backward compatibility with existing images

-- Add new columns to user_images table
ALTER TABLE user_images 
ADD COLUMN IF NOT EXISTS media_type TEXT DEFAULT 'image' CHECK (media_type IN ('image', 'video')),
ADD COLUMN IF NOT EXISTS file_extension TEXT DEFAULT 'jpg',
ADD COLUMN IF NOT EXISTS thumbnail_url TEXT;

-- Create index for faster queries by media type
CREATE INDEX IF NOT EXISTS idx_user_images_media_type ON user_images(media_type);

-- Update existing rows to have proper defaults
UPDATE user_images 
SET media_type = 'image', 
    file_extension = 'jpg'
WHERE media_type IS NULL;

-- Optional: Rename table to user_media for clarity (uncomment if desired)
ALTER TABLE user_images RENAME TO user_media;

-- Note: You'll also need to create a new storage bucket named 'user-generated-videos'
-- in your Supabase Dashboard under Storage section

