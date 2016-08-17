class AddBankAccountAndBankAccountNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bank_account, :string
    add_column :users, :bank_account_number, :string
  end
end
