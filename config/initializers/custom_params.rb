module ActionDispatch
    module Http
        module Parameters
            extend ActiveSupport::Concern

            private

            def parse_formatted_parameters(parsers)
                parsers[Mime[:json].symbol] = Proc.new { |raw_post|
                    patched_string = raw_post.gsub(/\d+/, '"\0"').gsub('""','"')
                    data = ActiveSupport::JSON.decode(patched_string) rescue nil
                    if !data
                        data = patched_string
                    end
                    data.is_a?(Hash) ? data : { _json: data }
                }

                return yield if content_length.zero? || content_mime_type.nil?

                strategy = parsers.fetch(content_mime_type.symbol) { return yield }

                begin
                    strategy.call(raw_post)
                rescue # JSON or Ruby code block errors.
                    my_logger = logger || ActiveSupport::Logger.new($stderr)
                    my_logger.debug "Error occurred while parsing request parameters.\nContents:\n\n#{raw_post}"

                raise ParseError
                end
            end
        end
    end
end