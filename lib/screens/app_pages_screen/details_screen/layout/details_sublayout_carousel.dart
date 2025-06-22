import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart'; // ✅ Added import
import 'package:kobin/common/api.dart';
import '../../../../config.dart';
import '../../../../plugin_list.dart';

class DetailsSubLayoutCarousel extends StatefulWidget {
  final dynamic product;
  const DetailsSubLayoutCarousel({super.key, required this.product});

  @override
  State<DetailsSubLayoutCarousel> createState() =>
      _DetailsSubLayoutCarouselState();
}

class _DetailsSubLayoutCarouselState extends State<DetailsSubLayoutCarousel> {
  late List<String> imageUrls;
  late List<String> videoUrls;

  @override
  void initState() {
    super.initState();

    imageUrls = (widget.product['images'] as List<dynamic>)
        .map((image) => image['url'] as String)
        .toList();

    videoUrls = (widget.product['videos'] as List<dynamic>)
        .map((image) => image['url'] as String)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailsProvider>(
      builder: (context1, details, child) {
        return CarouselSlider.builder(
          carouselController: details.carouselController,
          itemCount: imageUrls.length + videoUrls.length,
          itemBuilder: (context, index, realIndex) {
            final isVideo = index >= imageUrls.length;
            final mediaUrl = isVideo
                ? videoUrls[index - imageUrls.length]
                : imageUrls[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullScreenMediaPage(
                      mediaUrls: isVideo ? videoUrls : imageUrls,
                      initialIndex: isVideo ? index - imageUrls.length : index,
                    ),
                  ),
                );
              },
              child: isVideo
                  ? VideoWidget(videoUrl: mediaUrl)
                  : DetailsCarousel(data: mediaUrl, index: index == realIndex),
            );
          },
          options: CarouselOptions(
            disableCenter: true,
            padEnds: false,
            enlargeStrategy: CenterPageEnlargeStrategy.scale,
            height: Sizes.s300,
            viewportFraction: 1,
            enableInfiniteScroll: true,
            enlargeCenterPage: true,
            enlargeFactor: 0.45,
            initialPage: 0,
            animateToClosest: true,
            autoPlay: false,
            pauseAutoPlayOnTouch: true,
            pauseAutoPlayOnManualNavigate: true,
          ),
        );
      },
    );
  }
}

class FullScreenMediaPage extends StatefulWidget {
  final List<String> mediaUrls;
  final int initialIndex;

  FullScreenMediaPage({required this.mediaUrls, required this.initialIndex});

  @override
  _FullScreenMediaPageState createState() => _FullScreenMediaPageState();
}

class _FullScreenMediaPageState extends State<FullScreenMediaPage> {
  late int currentIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Full Screen Media'),
      ),
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.primaryDelta! < -20) {
            _pageController.nextPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          } else if (details.primaryDelta! > 20) {
            _pageController.previousPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          }
        },
        child: PageView.builder(
          controller: _pageController,
          itemCount: widget.mediaUrls.length,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            final mediaUrl = widget.mediaUrls[index];
            if (mediaUrl.endsWith(".mov") || mediaUrl.endsWith(".mp4")) {
              return VideoWidget(videoUrl: mediaUrl);
            } else {
              return CachedNetworkImage(
                imageUrl: resolveImageUrl(mediaUrl),
                fit: BoxFit.contain,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Center(
                  child: Icon(Icons.error),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class VideoWidget extends StatefulWidget {
  final String videoUrl;

  VideoWidget({required this.videoUrl});

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
      });
    _controller.setLooping(true);
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _controller.value.isInitialized
          ? InkWell(
              child: Stack(
                children: [
                  Center(
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                  _controller.value.isPlaying
                      ? Container()
                      : Center(
                          child: Icon(
                            Icons.play_arrow,
                            size: 100,
                            color: Color.fromRGBO(92, 92, 92, 0.781),
                          ),
                        ),
                ],
              ),
              onTap: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
            )
          : Container(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
