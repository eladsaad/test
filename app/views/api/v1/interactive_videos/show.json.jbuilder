json.extract! @program_video.interactive_video, :id, :name, :description, :content
json.partial! 'program_video_surveys', program_video: @program_video