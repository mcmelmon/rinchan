ActiveAdmin.register User do
  permit_params :editor, :email, :is_active, :name, :password, :password_confirmation

  index do |idx|
    column :email
    column :name
    column t('activerecord.models.topic') do |user|
      div do
        user.topics.count
      end
    end
    column t('activerecord.models.bump') do |user|
      div do
        user.bumps.count
      end
    end
    column t('activerecord.models.objection') do |user|
      div do
        user.objections.count
      end
    end
    column t('activerecord.models.reply') do |user|
      div do
        user.replies.count
      end
    end
    column t('activerecord.models.thank') do |user|
      div do
        user.thanks.count
      end
    end
    column t('activerecord.models.demurral') do |user|
      div do
        user.demurrals.count
      end
    end
    column :editor
    column :is_active
    column :updated_at
    actions
  end

  filter :email

  form do |f|
    f.inputs do
      f.input :email
      f.input :name
      f.input :is_active
      f.input :editor
    end
    f.actions
  end
end
