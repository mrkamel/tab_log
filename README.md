
# TabLog

Write tab delimited logs with an ActiveRecord alike interface

<pre>
class Download
  def fields
    [:timestamp, :user_id]
  end
end

...

Download.new(:timestamp => Time.now, :user_id => current_user.id)
</pre>

