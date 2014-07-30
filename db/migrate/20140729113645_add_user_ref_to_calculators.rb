class AddUserRefToCalculators < ActiveRecord::Migration
  def change
    add_reference :calculators, :user, index: true
  end
end
