module LogHelper
  def create_log p_user_id, note, object
    user_id = p_user_id
    user_name = User.find_by_uuid(p_user_id).email
    Log.create(user_id: user_id, user_name: user_name, note: note, object: object.to_json(:except => [:uuid, :created_at, :updated_at]))
  end
  
  def create_log_2 p_user_id, note, text
    user_id = p_user_id
    user_name = User.find_by_uuid(p_user_id).email
    Log.create(user_id: user_id, user_name: user_name, note: note, object: text)
  end
  
  def create_log_3 p_user_id, note, object, arr_to_display
    user_id = p_user_id
    user_name = User.find_by_uuid(p_user_id).email
    Log.create(user_id: user_id, user_name: user_name, note: note, object: object.to_json(:only => arr_to_display))
  end
end