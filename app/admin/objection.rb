ActiveAdmin.register Objection do
  permit_params :body

  index do |idx|
    column t('activerecord.models.user') do |objection|
      div do
        link_to objection.user.email, user_path(objection.user)
      end
    end
    column t('activerecord.models.topic') do |objection|
      div do
        link_to objection.topic.subject.truncate(14), topic_path(objection.topic)
      end
    end
    column :body
    column :created_at
    column :updated_at
    actions
  end

  filter :body
  filter :topic_subject_cont
  filter :user_email_cont

  form do |f|
    f.inputs do
      f.input :body
    end
    f.actions
  end
end
