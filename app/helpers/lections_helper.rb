module LectionsHelper
     include ActsAsTaggableOn::TagsHelper
end
class Time
  def toDateTime
    dateTimeString = self.to_s.split
    localTimeString = "#{dateTimeString[1].split(':')[0].to_i + 3}:#{dateTimeString[1].split(':')[1]}:#{dateTimeString[1].split(':')[2]}"
    "#{dateTimeString[0].split('-').reverse.join('.')} #{localTimeString}"
  end
end
