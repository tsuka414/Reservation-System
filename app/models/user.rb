class User < ApplicationRecord
  has_many :attendances, dependent: :destroy
  attr_accessor :remember_token
  before_save { self.email = email.downcase }

  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 100 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true    
  validates :department, length: { in: 2..30 }, allow_blank: true
  validates :basic_work_time, presence: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  
  def User.digest(string)
    cost = 
      if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
    BCrypt::Password.create(string, cost: cost)
  end
  
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  def self.search(search) #ここでのself.はMicropost.を意味する
    if search
      where([ 'name LIKE ?', "%#{search}%"]) #検索とcontentの部分一致を表示。Micropost.は省略。
    else
      all #全て表示。Micropost.は省略。
    end
  end
  
  def self.import(file)
    imported_num = 0
    open(file.path, 'r:cp932:utf-8', undef: :replace) do |f|
      # csv = CSV.new(f, :headers => :first_row)
      caches = User.all.index_by(&:id)
      CSV.foreach(file.path, headers: true) do |row|
        next if row.header_row?
        #CSVの行情報をHASHに変換
        table = Hash[[row.headers, row.fields].transpose]
        #登録済みデータ情報
        #登録されてなければ作成
        user = caches[table['id']]
        if user.nil?
           user = new
        end
        #データ情報更新
        user.attributes = row.to_hash.slice(*updatable_attributes)
        #バリデーションokの場合は保存
        if user.valid?
          user.save!
          imported_num += 1
        end
      end
    end
    #更新件数を返す
    imported_num
  end
  
  # 更新を許可するカラムを定義
  def self.updatable_attributes
    ["name", "email", "department", "employee_number", "uid", "basic_work_time",
     "designated_work_start_time", "designated_work_end_time", "superior", "admin",
     "password"]
  end



end