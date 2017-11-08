# SimplePlugin

SimplePlugin is a boilerplate RapidWeaver plugin to use as a starting point. It impliments the minimum set of API, views, and icons. It saves using NSCoding and communicates with views with simple bindings.

The plugin impliments a basic side-by-side style Markdown editor using RapidWeaver's built in markdown functionality.


### Usage

Download or fork the repository, open in Xcode, Build and Run. It should build a RapidWeaver plugin, install it into your addons folder, and run RapidWeaver 7 connected to lldb.

### Requirements

- Xcode 9
- RapidWeaver 7.5

This project will attempt to use RapidWeaver 7 to link against its frameworks and for Build & Run.  You should have RapidWeaver installed in the standard location:  `/Applications/RapidWeaver 7.app`

You do ***NOT*** need to have your addons folder in the standard location. The install script (a Build-stage post-action) will find the addons folder custom location if you have one set.

### Compatibility

The built plugin will be compatible with RapidWeaver 7. Without too much effort this could be made to work in RapidWeaver 6 as well.

### Other Resources

This is not meant to be a replacement of the RWPluginKit or the RealmacSoftware Sample Plugin which demonstrates a wider set of API and comes with a complete set of resources like the RWKit and RMKit. You can find that here: https://github.com/realmacsoftware/RWPluginKit


### License

SimplePlugin is released under the MIT license. This means you can copy it and reuse it in your own projects.

Although not required, if you do use this project, I'd appreciate a mention somewhere. Thanks.