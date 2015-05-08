Yt.configure do |config|
  config.api_key = ENV['youtube_key']
end

class Yt::Models::Video
  def embed_html5(params = {})
    opts = {:class  => params[:class]  || "",
            :id     => params[:id]     || "",
            :width  => params[:width]  || "425",
            :height => params[:height] || "350",
            :protocol => params[:protocol] || "http",
            :frameborder => params[:frameborder] || "0",
            :url_params => params[:url_params] || {},
            :sandbox => params[:sandbox] || false,
            :fullscreen => params[:fullscreen] || false,
            }
    url_opts = opts[:url_params].empty? ? "" : "?#{Rack::Utils::build_query(opts[:url_params])}"
    <<EDOC
<iframe class="#{opts[:class]}" id="#{opts[:id]}" type="text/html" width="#{opts[:width]}" height="#{opts[:height]}" src="#{opts[:protocol]}://www.youtube.com/embed/#{id}#{url_opts}" frameborder="#{opts[:frameborder]}" #{" sandbox=\"#{opts[:sandbox]}\" " if opts[:sandbox]} #{"allowfullscreen" if opts[:fullscreen]}></iframe>
EDOC
  end
end
