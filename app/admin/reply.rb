ActiveAdmin.register Reply do
  permit_params :anonymous, :body, :hide, :user_id

  index do |idx|
    column t('activerecord.models.user') do |reply|
      div do
        link_to reply.user.email, user_path(reply.user)
      end
    end
    column t('activerecord.models.topic') do |reply|
      div do
        link_to reply.topic.subject.truncate(14), topic_path(reply.topic)
      end
    end
    column :anonymous
    column :hide
    column :body
    column t('activerecord.models.thank') do |reply|
      div do
        reply.thanks.count
      end
    end
    column t('activerecord.models.demurral') do |reply|
      div do
        reply.demurrals.count
      end
    end
    column :created_at
    column :updated_at
    actions
  end

  filter :body
  filter :topic_subject_cont
  filter :user_email_cont

  form do |f|
    f.inputs do
      f.input :user, as: :select, collection: User.pluck(:email, :id).push(reply.persisted? ? [f.object.user.email, f.object.user.id] : []).uniq.sort
      f.input :anonymous
      f.input :hide
      f.input :body
    end
    f.actions
  end
end
