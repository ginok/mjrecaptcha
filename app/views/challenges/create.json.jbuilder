json.token @challenge.token
json.pai_positions @challenge.pai_positions do |pai_position|
  json.image_url pai_position.image_url
  json.x pai_position.x
  json.y pai_position.y
  json.w pai_position.width
  json.h pai_position.height
end
