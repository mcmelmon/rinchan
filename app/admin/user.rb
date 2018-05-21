ActiveAdmin.register User do
  permit_params :email

  index do |idx|
    column :email
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
    column :created_at
    column :updated_at
    actions
  end

  filter :email

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
