class AlterInterview < ActiveRecord::Migration[5.1]
  def change
    rename_column :interviews, :expected, :unused
    rename_column :interviews, :frequent, :elsewhere
    rename_column :interviews, :useful, :cumbersome
    add_column :interviews, :expense, :boolean
    add_column :interviews, :accuracy, :boolean
    add_column :interviews, :specific, :boolean
    add_column :interviews, :applicable, :boolean
  end
end
