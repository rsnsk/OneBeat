' autorun.brs - BrightSign HD1026 - OS9
' Launches index.html from the dist/ folder on the SD card

function main()
    ' Create directory to store crash-dumps (optional but helps with diagnostics)
    dir = CreateDirectory("SD:/brightsign-dumps")

    mp = CreateObject("roMessagePort")

    widget = CreateHTMLWidget(mp)
    widget.Show()

    ' Serial is handled from Node.js inside the HTML widget (nodejs_enabled: true)
    ' Just keep the event loop alive
    while true
        msg = wait(0, mp)
    end while
end function

function CreateHTMLWidget(mp as object) as object
    ' Force 1080p output (HD1026 max resolution)
    vidmode = CreateObject("roVideoMode")
    vidmode.SetMode("1920x1080x60p")
    width = vidmode.GetResX()
    height = vidmode.GetResY()

    r = CreateObject("roRectangle", 0, 0, width, height)

    config = {
        nodejs_enabled: true
        url: "file:///sd:/dist/index.html"
        port: mp
    }

    h = CreateObject("roHtmlWidget", r, config)
    return h
end function
