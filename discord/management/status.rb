module Status
  def self.activate(_event)
    YANDERE.update_status(      \
      'online',                 \
      CONFIG['bot']['version'], \
      nil,                      \
      0,                        \
      false,                    \
      0                         \
    )
  end
end
