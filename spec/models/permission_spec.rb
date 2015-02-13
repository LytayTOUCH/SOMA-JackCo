require 'spec_helper'

describe Permission, 'validation' do
  
end

describe Permission, 'column-specification' do
  it { should have_db_column(:name).of_type(:string).with_options(length: { maximum: 50 }) }
  it { should have_db_column(:user_group_id).of_type(:string).with_options(length: { maximum: 36 }) }
  it { should have_db_column(:resource_id).of_type(:string).with_options(length: { maximum: 36 }) }
  it { should have_db_column(:access_full).of_type(:boolean) }
  it { should have_db_column(:access_list).of_type(:boolean) }
  it { should have_db_column(:access_create).of_type(:boolean) }
  it { should have_db_column(:access_update).of_type(:boolean) }
  it { should have_db_column(:access_delete).of_type(:boolean) }
end  
