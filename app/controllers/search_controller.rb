class SearchController < ApplicationController
  before_action :generate_readable_results

  def index
  end

  private
    def generate_readable_results
      raw_results = PgSearch.multisearch(params[:search]).paginate(page: params[:page])
      @results = []

      if @results.present?
        raw_results.each do |raw|
          case raw.searchable_type
          when 'Topic'
            topic = Topic.find_by(id: raw.searchable_id)
            @results.push({type: 'Topic', topic: topic}) unless @results.select {|result| result.has_value?(topic)}.present?
          when 'Tag'
            topic = Tag.find_by(id: raw.searchable_id).topic
            @results.push({type: 'Tag', topic: topic }) unless @results.select {|result| result.has_value?(topic)}.present?
          when 'Reply'
            reply = Reply.find_by(id: raw.searchable_id)
            topic = reply.topic
            @results.push({type: 'Reply', topic: topic, reply: reply}) unless @results.select {|result| result.has_value?(reply)}.present?
          else
            nil
          end
        end
      else
        @results = Topic.where('subject like ?', "%#{params[:search]}%")
      end
      @results
    end
end
