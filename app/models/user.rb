class User < ApplicationRecord
    attr_accessor :remember_token
    # emailは全て小文字で保存
    before_save { email.downcase! }
    # 空でないこと・長さ制限
    validates :name, presence: true, length:{maximum: 20}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length:{maximum: 100},
        format: { with: VALID_EMAIL_REGEX }, # emailの形式（正規表現）
        uniqueness: true # 同じメールアドレスは無効
    # パスワードをハッシュ化
    has_secure_password
    validates :password, presence: true, length: { minimum: 10 }, allow_nil: true
    
    # 渡された文字列のハッシュ値を返す
    def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
    end
    
  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
   # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
end
