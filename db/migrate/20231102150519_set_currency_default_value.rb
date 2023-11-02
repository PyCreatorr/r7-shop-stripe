class SetCurrencyDefaultValue < ActiveRecord::Migration[7.0]
  def up
    change_table :products do |t|
      t.change :currency, :string, default: 'usd'
    end
  end

  def down
    change_table :products do |t|
      t.change :currency, :string
    end
  end
end
