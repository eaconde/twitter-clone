class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tweets

  def as_json(options={})
    {id: id, name: name, gravatar: gravatar}
  end

  def name
    first_name.present? ? "#{first_name} #{last_name}" : email
  end

  def self.random(current_user_id)
    where(["id != :current_user_id", {current_user_id: current_user_id}])
    .order("random()")
    .all
  end

  def gravatar
    hash = Digest::MD5.hexdigest(email)
    "http://www.gravatar.com/avatar/#{hash}"
  end
end
