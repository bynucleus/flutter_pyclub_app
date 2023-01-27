'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "81291ee809be2ee6ef698b06ccf68475",
"assets/assets/fonts/Poppins-Bold.ttf": "c23534acbeddbaadfd0ab2d2bbfdfc84",
"assets/assets/fonts/Poppins-ExtraBold.ttf": "6b78c7ec468eb0e13c6c5c4c39203986",
"assets/assets/fonts/Poppins-Light.ttf": "2a47a29ceb33c966c8d79f8d5a5ea448",
"assets/assets/fonts/Poppins-Medium.ttf": "ba95810b56f476990ca71d15139d5111",
"assets/assets/fonts/Poppins-Regular.ttf": "41e8dead03fb979ecc23b8dfb0fef627",
"assets/assets/images/avatar.png": "1ee966d656f02e2e41912d7622009854",
"assets/assets/images/background-4.png": "bdd6181f9a9fccf326de81610357305d",
"assets/assets/images/dev.jfif": "dc26bb488cc799277f49195addc0966e",
"assets/assets/images/dev.jpg": "9637a8b35b893ffc00b213e257c02c26",
"assets/assets/images/meme.gif": "0de31cc56b5e7b0f06cd26f74802018f",
"assets/assets/images/men_wearing_jacket.gif": "c5738331b11f3db2db8ad0b3776966a7",
"assets/assets/images/myclub.png": "e622702b56f62e84463fd917ca1dbf47",
"assets/assets/images/myclubmini.png": "3782854362ceff164513ae236cade096",
"assets/assets/images/pyclub.png": "7d8b00025f1ae344b9744ceafc0177cd",
"assets/assets/images/pyclub_logo.png": "817c6dad518a74021264103e96f76b2f",
"assets/assets/images/py_icon.png": "219567126e223735b6b85a6174b8a06a",
"assets/assets/images/py_logo.png": "6c7162443ec21cfd4d47d33370dd3e70",
"assets/assets/images/space_demo.flr": "5403c701d61b4da9df509b8dc29d49c4",
"assets/assets/svg/avator1.svg": "f5bb25989a36b2ada862d7296a544e7d",
"assets/assets/svg/avator10.svg": "51eecd1d66c3c0f309afb0edb06aa18c",
"assets/assets/svg/avator11.svg": "8f9c88ade9362418d8d523c6482492b7",
"assets/assets/svg/avator12.svg": "0d6490dc67d22be38a368404e1e32d56",
"assets/assets/svg/avator13.svg": "d6a2b9e6ae15c35fc12db52c695e2819",
"assets/assets/svg/avator14.svg": "1ce19ae8abc97fbab0eda58ee9091c1d",
"assets/assets/svg/avator15.svg": "b661f8120984505c23196f4dc1d5b383",
"assets/assets/svg/avator16.svg": "d3ea76db47c921c21ec6a4c67c9a6daa",
"assets/assets/svg/avator17.svg": "91f7e377a719661a9ef3e6398f9c76ea",
"assets/assets/svg/avator2.svg": "a48f2b7f33e230a61e8c6012092ca68b",
"assets/assets/svg/avator3.svg": "e2edf8a0f28a5df6e2b2708f81ad2191",
"assets/assets/svg/avator4.svg": "6815b089a27852653c425b1d18607238",
"assets/assets/svg/avator5.svg": "0f2a3f509aed0b43f21a38c5e1d0f174",
"assets/assets/svg/avator6.svg": "6062431b1bdb01e411c2e4060b4b90df",
"assets/assets/svg/avator7.svg": "564fb17c1333601b2b8f2236b08c6ca6",
"assets/assets/svg/avator8.svg": "605b06bea88e41754cb136c12300b98e",
"assets/assets/svg/avator9.svg": "fbbc4a875855efff7a4780df745d8d2b",
"assets/assets/svg/bg_home.svg": "884046ae38cbd9cc15d7455427147ec9",
"assets/assets/svg/cashback.svg": "fa15bea6ffbf0eff61c0fdd94c861b4c",
"assets/assets/svg/cloud.svg": "75b7a4b24e77f7f7e403af1c4206d295",
"assets/assets/svg/cross.svg": "d2071d56c315636a5609b9874e8ae43c",
"assets/assets/svg/electricity.svg": "4f2568151ffc227d2f60e9e37d4c6e9d",
"assets/assets/svg/filter.svg": "195629fa4e89e2601b4635a94c4d615d",
"assets/assets/svg/flight.svg": "9b38d9d507a9e576035e8fe91c6c12ea",
"assets/assets/svg/logo.svg": "b44830dafb9ae6fc9ced6a707094922b",
"assets/assets/svg/logout.svg": "c61636ab684648a78d3fc0445268c858",
"assets/assets/svg/menu.svg": "193c58d0d0c64031b07d5fdaa89bbee5",
"assets/assets/svg/mobile.svg": "ecc061a0cc14f69fbf9a7b324e669a98",
"assets/assets/svg/more.svg": "0d6399ff5f3ed209d6d5c9baffd4146c",
"assets/assets/svg/movie.svg": "cc7fcf1679c75dc486baaac238b1b96d",
"assets/assets/svg/receive.svg": "c3e10281c0096a0f492abb3c07fd665a",
"assets/assets/svg/scan.svg": "61d77be8966bc80112392c3aa7fb5e61",
"assets/assets/svg/send.svg": "4d3ca9705f371b1a43fcf6e215eab39f",
"assets/FontManifest.json": "1e3f7ec5e9d0958fa738153c3563e1fc",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/NOTICES": "be3c3631fc1fe4368d24fabfbb925fbe",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "e7006a0a033d834ef9414d48db3be6fc",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "b37ae0f14cbc958316fac4635383b6e8",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "5178af1d278432bec8fc830d50996d6f",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "aa1ec80f1b30a51d64c72f669c1326a7",
"assets/shaders/ink_sparkle.frag": "6333b551ea27fd9d8e1271e92def26a9",
"canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "cf1527e7fd673c89aecca06330cc6305",
"/": "cf1527e7fd673c89aecca06330cc6305",
"main.dart.js": "de3e2d4cf6d8e34f5f0a73a52ce4084d",
"manifest.json": "8e8f042da0e9d21df8b6645b6e50224f",
"version.json": "69ee5ce0b70c7ae8ecf2b99ff56bcc3b"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
