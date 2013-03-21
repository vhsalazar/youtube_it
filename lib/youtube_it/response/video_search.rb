class YouTubeIt
  module Response
    class FeedSearch < YouTubeIt::Record
      # *String*:: Unique feed identifying url.
      attr_reader :feed_id 
      
      # *Fixnum*:: Number of results per page.
      attr_reader :max_result_count
      
      # *Fixnum*:: 1-based offset index into the full result set.
      attr_reader :offset
      
      # *Fixnum*:: Total number of results available for the original request.
      attr_reader :total_result_count

      # *Time*:: Date and time at which the feed was last updated
      attr_reader :updated_at

      def current_page
        ((offset - 1) / max_result_count) + 1
      end
      
      # current_page + 1 or nil if there is no next page
      def next_page
        current_page < total_pages ? (current_page + 1) : nil
      end

      # current_page - 1 or nil if there is no previous page
      def previous_page
        current_page > 1 ? (current_page - 1) : nil
      end

      def total_pages
        (total_result_count / max_result_count.to_f).ceil
      end
    end
    class VideoSearch < FeedSearch
      # *Array*:: Array of YouTubeIt::Model::Video records
      attr_reader :videos
    end

    class CommentSearch < FeedSearch
      # *Array*:: Array of YouTubeIt::Model::Comment records
      attr_reader :comments
    end
  end
end
