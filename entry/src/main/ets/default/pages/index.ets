// @ts-nocheck
//Text组件：文本组件，用于呈现一段信息。
//Image组件：图片组件，用来渲染展示图片。
//Slider组件：滑动条组件，用来快速调节设置值，如音量、亮度等。
//在声明式UI中，所有的页面都是由组件构成。组件的数据结构为struct，装饰器@Component是组件化的标志，用@Component修饰的struct表示这个结构体有了组件化的能力。
//@Entry修饰的Component表示该Component是页面的总入口，也可以理解为页面的根节点。值得注意的是，一个页面有且仅能有一个@Entry，只有被@Entry修饰的组件或者其子组件，才会在页面上显示。@Entry
//@Component和@Entry都是基础且十分重要的装饰器。简单地理解，装饰器就是某一种修饰，给被装饰的对象赋予某一种能力，比如@Entry就是页面入口的能力，@Component就是组件化能力。
//rotate 可以分别设置绕X轴、Y轴、Z轴的旋转角度，正角度为顺时针转动，负角度为逆时针转动，默认值为0，同时可以通过centerX和centerY设置旋转的中心点。
//scale 可以分别设置X轴、Y轴、Z轴的缩放比例，默认值为1，同时可以通过centerX和centerY设置缩放的中心点。
@Entry
@Component
struct Index {
  @State private speed: number = 5
  @State private imageSize: number = 1
  @State private angle: number = 0
  @State private interval: number = 0
  @State private transparency: number = 0.5
  @Builder DescribeText(text:String,speed:number) {
    Stack() {
      Text(text + speed.toFixed(1))
        .margin({top:30})
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
    }
  }
  build() {
    Column() {
      Image($rawfile('windmill.png'))
        .objectFit(ImageFit.Contain)
        .height(150)
        .width(150)
        .margin({top:50,bottom:150,right:16})
        .rotate({x:0,y:0,z:1,angle:this.angle})
        .scale({x:this.imageSize,y:this.imageSize})
        .opacity(this.transparency)

      this.DescribeText('速度：',this.speed)

      Slider({value:this.speed,min:1,max:10,step:1,style:SliderStyle.OutSet})
        .showTips(true)
        .blockColor(Color.Blue)
        .onChange((value:number,mode:SliderChangeMode) =>{
          this.speed = value
          clearInterval(this.interval)
          this.speedChange()
        })

      this.DescribeText('缩放比例：', this.imageSize)

      Slider({value:this.imageSize,min:0.5,max:2.5,step:0.1,style:SliderStyle.OutSet})
        .showTips(true)
        .blockColor(Color.Blue)
        .onChange((value:number,mode:SliderChangeMode) =>{
          this.imageSize = value
        })

      this.DescribeText('透明度：', this.transparency)

      Slider({value:this.transparency,min:0.1,max:1,step:0.1,style:SliderStyle.OutSet})
        .showTips(true)
        .blockColor(Color.Blue)
        .onChange((value:number,mode:SliderChangeMode) =>{
          this.transparency = value
        })
    }
    .width('100%')
    .height('100%')
  }
  //可以分别设置X轴、Y轴、Z轴的缩放比例，默认值为1，同时可以通过centerX和centerY设置缩放的中心点。
  speedChange() {
    var that = this;
    that.angle = 0;
    this.interval = setInterval(function() {
      that.angle += that.speed
    },15)
  }
  //onPageShow是生命周期方法，表示从程序启动时，便开始执行。
  onPageShow() {
    clearInterval(this.interval)
    this.speedChange()
  }
}

