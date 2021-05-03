class User < ApplicationRecord
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
    validates :password, presence: true, length: { minimum: 10 }
end
