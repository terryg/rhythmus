class Timer

  attr_accessor :running
  
  def initialize
    restart
  end
  
  def restart
    @running = Time.now
  end
  
  def elapsed
    time = Time.now - @running

	h = time.to_i / 3600
	m = (time.to_i % 3600) / 60
	s = time.to_i % 60
	micro = ((time - time.to_i)*10).to_i
	time = sprintf("%02i:%02i:%02i.%1i", h, m, s, micro)

    return time
  end
  
end