ActiveAdmin.register Topic do
  permit_params :anonymous, :feature, :hide, :subject, :user_id

  index do |idx|
    column t('activerecord.models.user') do |topic|
      div do
        link_to topic.user.email, user_path(topic.user)
      end
    end
    column :anonymous
    column :feature
    column :hide
    column :subject
    column t('activerecord.models.bump') do |topic|
      div do
        topic.bumps.count
      end
    end
    column t('activerecord.models.objection') do |topic|
      div do
        topic.objections.count
      end
    end
    column t('activerecord.models.reply') do |topic|
      div do
        topic.replies.count
      end
    end
    column :created_at
    column :updated_at
    actions
  end

  filter :subject
  filter :user_email_cont

  form do |f|
    f.inputs do
      f.input :user, as: :select, collection: User.pluck(:email, :id).push(topic.persisted? ? [f.object.user.email, f.object.user.id] : []).uniq.sort
      f.input :anonymous
      f.input :feature
      f.input :hide
      f.input :subject
    end
    f.actions
  end
end
