import 'package:jaspr/browser.dart';
import 'package:jaspr/jaspr.dart';
import 'package:web/web.dart' as web;

class Header extends StatelessComponent {
  final void Function(web.FileList files) onSelected;

  const Header({super.key, required this.onSelected});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(classes: 'navbar bg-base-100', [
      div(classes: 'flex-none', [
        input(
            type: InputType.file,
            classes: 'collapse hidden',
            onChange: (files) => onSelected(files as web.FileList),
            []),
        button(classes: 'btn btn-square btn-ghost', onClick: () {
          (web.document.querySelector('input[type="file"]') as web.HTMLElement?)
              ?.click();
        }, [
          svg(
              classes: 'size-6',
              attributes: {
                'fill': 'none',
                'stroke-width': '1.5',
                'stroke': 'currentColor'
              },
              viewBox: '0 0 24 24',
              [
                path(
                    attributes: {
                      'stroke-linecap': 'round',
                      'stroke-linejoin': 'round'
                    },
                    d: "M3.75 9.776c.112-.017.227-.026.344-.026h15.812c.117 0 .232.009.344.026m-16.5 0a2.25 2.25 0 0 0-1.883 2.542l.857 6a2.25 2.25 0 0 0 2.227 1.932H19.05a2.25 2.25 0 0 0 2.227-1.932l.857-6a2.25 2.25 0 0 0-1.883-2.542m-16.5 0V6A2.25 2.25 0 0 1 6 3.75h3.879a1.5 1.5 0 0 1 1.06.44l2.122 2.12a1.5 1.5 0 0 0 1.06.44H18A2.25 2.25 0 0 1 20.25 9v.776",
                    []),
              ]),
        ]),
      ]),
    ]);
  }
}
