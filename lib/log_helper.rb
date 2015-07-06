module LogHelper
  def create_log p_user_id, note, object
    user_id = p_user_id
    user_name = User.find_by_uuid(p_user_id).email
    
    data = JSON.parse(object.to_json)
    str_to_record = ""
    data.each do |element|
      str_to_record += element.to_s + "\n"
    end
    
    Log.create(user_id: user_id, user_name: user_name, note: note, object: str_to_record)
  end
  
  def create_log_2 p_user_id, note, text
    user_id = p_user_id
    user_name = User.find_by_uuid(p_user_id).email
    Log.create(user_id: user_id, user_name: user_name, note: note, object: text)
  end
end