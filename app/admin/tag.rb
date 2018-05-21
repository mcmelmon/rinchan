ActiveAdmin.register Tag do
  permit_params :name

  index do |idx|
    column t('activerecord.models.user') do |tag|
      div do
        link_to tag.user.email, user_path(tag.user)
      end
    end
    column t('activerecord.models.topic') do |tag|
      div do
        link_to tag.topic.subject.truncate(14), topic_path(tag.topic)
      end
    end
    column :name
    column :created_at
    column :updated_at
    actions
  end

  filter :name
  filter :topic_subject_cont
  filter :user_email_cont

  form do |f|
    f.inputs do
      f.input :name
    end
    f.actions
  end
end
