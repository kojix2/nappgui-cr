module GUI
  abstract class Application
    protected class_property! instance : Application
    getter! window : GUI::Window

    abstract def gui : GUI::Window

    def init
    end

    def done
    end

    def update
    end

    protected def do_init
      @window = gui
      init
      window.show
    end

    protected def do_done
      done
      window.destroy
    end

    protected def do_update(step)
      Fiber.yield
      update
    end

    def run
      Application.instance = self
      LibGUI.osmain_imp(0, nil, nil, 0.05, ->{ Application.instance.do_init }, ->(data : Void*, ltime : Float64, ctime : Float64) { Application.instance.do_update(ctime - ltime) }, ->(data : Void**) { Application.instance.do_done }, "")
    end
  end
end
