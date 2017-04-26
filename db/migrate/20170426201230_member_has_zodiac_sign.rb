class MemberHasZodiacSign < ActiveRecord::Migration[5.0]
  def change
    add_column :members, :zodiac_sign, :integer
  end
end
