import 'dart:async';

import 'package:rxdart/rxdart.dart' as RxDart;
import 'package:rxdart/streams.dart';

class BehaviorSubject<T> {
  BehaviorSubject({T value}) {
    if (value != null) {
      this.value = value;
    }
  }

  final RxDart.BehaviorSubject<T> _subject = RxDart.BehaviorSubject();

  Stream<T> get stream => _subject.stream;

  set value(T value) {
    _addEvent(value);
  }

  get value => _subject.value;

  _addEvent(T event) {
    if (!_subject.isClosed) {
      _subject.sink.add(event);
    }
  }

  addError(Object error) {
    if (!_subject.isClosed) {
      _subject.sink.addError(error);
    }
  }

  StreamSubscription listen(void onData(T event),
      {Function onError, void onDone(), bool cancelOnError}) {
    return _subject.listen(onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }

  void close() {
    _subject.close();
  }
}

class ReplaySubject<T> {
  ReplaySubject({T value}) {
    if (value != null) {
      this.value = value;
    }
  }

  final RxDart.ReplaySubject<T> _subject = RxDart.ReplaySubject();

  Stream<T> get stream => _subject.stream;

  set value(T value) {
    _addEvent(value);
  }

  get value => _subject.values[_subject.values.length - 1];

  _addEvent(T event) {
    if (!_subject.isClosed) {
      _subject.sink.add(event);
    }
  }

  addError(Object error) {
    if (!_subject.isClosed) {
      _subject.sink.addError(error);
    }
  }

  StreamSubscription listen(void onData(T event),
      {Function onError, void onDone(), bool cancelOnError}) {
    return _subject.listen(onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }

  void close() {
    _subject.close();
  }
}

class PublishSubject<T> {
  PublishSubject({T value}) {
    if (value != null) {
      this.value = value;
    }
  }

  T _value;
  RxDart.PublishSubject<T> _subject = RxDart.PublishSubject();

  Stream<T> get stream => _subject.stream;

  set value(T value) {
    _addEvent(value);
  }

  get value => this._value;

  _addEvent(T event) {
    if (!_subject.isClosed) {
      _subject.sink.add(event);
    }
  }

  addError(Object error) {
    if (!_subject.isClosed) {
      _subject.sink.addError(error);
    }
  }

  StreamSubscription listen(void onData(T event),
      {Function onError, void onDone(), bool cancelOnError}) {
    return _subject.listen(onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }

  void close() {
    _subject.close();
  }
}

abstract class Rx extends RxDart.Rx {
  /// Merges the given Streams into a single Stream sequence by using the
  /// [combiner] function whenever any of the stream sequences emits an item.
  /// This is helpful when you need to combine a dynamic number of Streams.
  ///
  /// The Stream will not emit any lists of values until all of the source
  /// streams have emitted at least one value.
  ///
  /// [Interactive marble diagram](http://rxmarbles.com/#combineLatest)
  ///
  /// ### Example
  ///
  ///    Rx.combineLatest([
  ///      Stream.value('a'),
  ///      Stream.fromIterable(['b', 'c', 'd'])
  ///    ], (list) => list.join())
  ///    .listen(print); // prints 'ab', 'ac', 'ad'
  static Stream<R> combineLatest<T, R>(
          Iterable<Stream<T>> streams, R Function(List<T> values) combiner) =>
      CombineLatestStream<T, R>(streams, combiner);

  /// Merges the given Streams into a single Stream that emits a List of the
  /// values emitted by the source Stream. This is helpful when you need to
  /// combine a dynamic number of Streams.
  ///
  /// The Stream will not emit any lists of values until all of the source
  /// streams have emitted at least one value.
  ///
  /// [Interactive marble diagram](http://rxmarbles.com/#combineLatest)
  ///
  /// ### Example
  ///
  ///     Rx.combineLatestList([
  ///       Stream.value(1),
  ///       Stream.fromIterable([0, 1, 2]),
  ///     ])
  ///     .listen(print); // prints [1, 0], [1, 1], [1, 2]
  static Stream<List<T>> combineLatestList<T>(Iterable<Stream<T>> streams) =>
      CombineLatestStream.list<T>(streams);

  /// Merges the given Streams into a single Stream sequence by using the
  /// [combiner] function whenever any of the stream sequences emits an
  /// item.
  ///
  /// The Stream will not emit until all streams have emitted at least one
  /// item.
  ///
  /// [Interactive marble diagram](http://rxmarbles.com/#combineLatest)
  ///
  /// ### Example
  ///
  ///     Rx.combineLatest2(
  ///       Stream.value(1),
  ///       Stream.fromIterable([0, 1, 2]),
  ///       (a, b) => a + b)
  ///     .listen(print); //prints 1, 2, 3
  static Stream<T> combineLatest2<A, B, T>(Stream<A> streamA, Stream<B> streamB,
          T Function(A a, B b) combiner) =>
      CombineLatestStream.combine2(streamA, streamB, combiner);

  /// Merges the given Streams into a single Stream sequence by using the
  /// [combiner] function whenever any of the stream sequences emits an
  /// item.
  ///
  /// The Stream will not emit until all streams have emitted at least one
  /// item.
  ///
  /// [Interactive marble diagram](http://rxmarbles.com/#combineLatest)
  ///
  /// ### Example
  ///
  ///     Rx.combineLatest3(
  ///       Stream.value('a'),
  ///       Stream.value('b'),
  ///       Stream.fromIterable(['c', 'c']),
  ///       (a, b, c) => a + b + c)
  ///     .listen(print); //prints 'abc', 'abc'
  static Stream<T> combineLatest3<A, B, C, T>(
          Stream<A> streamA,
          Stream<B> streamB,
          Stream<C> streamC,
          T Function(A a, B b, C c) combiner) =>
      CombineLatestStream.combine3(streamA, streamB, streamC, combiner);

  /// Merges the given Streams into a single Stream sequence by using the
  /// [combiner] function whenever any of the stream sequences emits an
  /// item.
  ///
  /// The Stream will not emit until all streams have emitted at least one
  /// item.
  ///
  /// [Interactive marble diagram](http://rxmarbles.com/#combineLatest)
  ///
  /// ### Example
  ///
  ///     Rx.combineLatest4(
  ///       Stream.value('a'),
  ///       Stream.value('b'),
  ///       Stream.value('c'),
  ///       Stream.fromIterable(['d', 'd']),
  ///       (a, b, c, d) => a + b + c + d)
  ///     .listen(print); //prints 'abcd', 'abcd'
  static Stream<T> combineLatest4<A, B, C, D, T>(
          Stream<A> streamA,
          Stream<B> streamB,
          Stream<C> streamC,
          Stream<D> streamD,
          T Function(A a, B b, C c, D d) combiner) =>
      CombineLatestStream.combine4(
          streamA, streamB, streamC, streamD, combiner);

  /// Merges the given Streams into a single Stream sequence by using the
  /// [combiner] function whenever any of the stream sequences emits an
  /// item.
  ///
  /// The Stream will not emit until all streams have emitted at least one
  /// item.
  ///
  /// [Interactive marble diagram](http://rxmarbles.com/#combineLatest)
  ///
  /// ### Example
  ///
  ///     Rx.combineLatest5(
  ///       Stream.value('a'),
  ///       Stream.value('b'),
  ///       Stream.value('c'),
  ///       Stream.value('d'),
  ///       Stream.fromIterable(['e', 'e']),
  ///       (a, b, c, d, e) => a + b + c + d + e)
  ///     .listen(print); //prints 'abcde', 'abcde'
  static Stream<T> combineLatest5<A, B, C, D, E, T>(
          Stream<A> streamA,
          Stream<B> streamB,
          Stream<C> streamC,
          Stream<D> streamD,
          Stream<E> streamE,
          T Function(A a, B b, C c, D d, E e) combiner) =>
      CombineLatestStream.combine5(
          streamA, streamB, streamC, streamD, streamE, combiner);

  /// Merges the given Streams into a single Stream sequence by using the
  /// [combiner] function whenever any of the stream sequences emits an
  /// item.
  ///
  /// The Stream will not emit until all streams have emitted at least one
  /// item.
  ///
  /// [Interactive marble diagram](http://rxmarbles.com/#combineLatest)
  ///
  /// ### Example
  ///
  ///     Rx.combineLatest6(
  ///       Stream.value('a'),
  ///       Stream.value('b'),
  ///       Stream.value('c'),
  ///       Stream.value('d'),
  ///       Stream.value('e'),
  ///       Stream.fromIterable(['f', 'f']),
  ///       (a, b, c, d, e, f) => a + b + c + d + e + f)
  ///     .listen(print); //prints 'abcdef', 'abcdef'
  static Stream<T> combineLatest6<A, B, C, D, E, F, T>(
          Stream<A> streamA,
          Stream<B> streamB,
          Stream<C> streamC,
          Stream<D> streamD,
          Stream<E> streamE,
          Stream<F> streamF,
          T Function(A a, B b, C c, D d, E e, F f) combiner) =>
      CombineLatestStream.combine6(
          streamA, streamB, streamC, streamD, streamE, streamF, combiner);

  /// Merges the given Streams into a single Stream sequence by using the
  /// [combiner] function whenever any of the stream sequences emits an
  /// item.
  ///
  /// The Stream will not emit until all streams have emitted at least one
  /// item.
  ///
  /// [Interactive marble diagram](http://rxmarbles.com/#combineLatest)
  ///
  /// ### Example
  ///
  ///     Rx.combineLatest7(
  ///       Stream.value('a'),
  ///       Stream.value('b'),
  ///       Stream.value('c'),
  ///       Stream.value('d'),
  ///       Stream.value('e'),
  ///       Stream.value('f'),
  ///       Stream.fromIterable(['g', 'g']),
  ///       (a, b, c, d, e, f, g) => a + b + c + d + e + f + g)
  ///     .listen(print); //prints 'abcdefg', 'abcdefg'
  static Stream<T> combineLatest7<A, B, C, D, E, F, G, T>(
          Stream<A> streamA,
          Stream<B> streamB,
          Stream<C> streamC,
          Stream<D> streamD,
          Stream<E> streamE,
          Stream<F> streamF,
          Stream<G> streamG,
          T Function(A a, B b, C c, D d, E e, F f, G g) combiner) =>
      CombineLatestStream.combine7(streamA, streamB, streamC, streamD, streamE,
          streamF, streamG, combiner);

  /// Merges the given Streams into a single Stream sequence by using the
  /// [combiner] function whenever any of the stream sequences emits an
  /// item.
  ///
  /// The Stream will not emit until all streams have emitted at least one
  /// item.
  ///
  /// [Interactive marble diagram](http://rxmarbles.com/#combineLatest)
  ///
  /// ### Example
  ///
  ///     Rx.combineLatest8(
  ///       Stream.value('a'),
  ///       Stream.value('b'),
  ///       Stream.value('c'),
  ///       Stream.value('d'),
  ///       Stream.value('e'),
  ///       Stream.value('f'),
  ///       Stream.value('g'),
  ///       Stream.fromIterable(['h', 'h']),
  ///       (a, b, c, d, e, f, g, h) => a + b + c + d + e + f + g + h)
  ///     .listen(print); //prints 'abcdefgh', 'abcdefgh'
  static Stream<T> combineLatest8<A, B, C, D, E, F, G, H, T>(
          Stream<A> streamA,
          Stream<B> streamB,
          Stream<C> streamC,
          Stream<D> streamD,
          Stream<E> streamE,
          Stream<F> streamF,
          Stream<G> streamG,
          Stream<H> streamH,
          T Function(A a, B b, C c, D d, E e, F f, G g, H h) combiner) =>
      CombineLatestStream.combine8(
        streamA,
        streamB,
        streamC,
        streamD,
        streamE,
        streamF,
        streamG,
        streamH,
        combiner,
      );

  /// Merges the given Streams into a single Stream sequence by using the
  /// [combiner] function whenever any of the stream sequences emits an
  /// item.
  ///
  /// The Stream will not emit until all streams have emitted at least one
  /// item.
  ///
  /// [Interactive marble diagram](http://rxmarbles.com/#combineLatest)
  ///
  /// ### Example
  ///
  ///     Rx.combineLatest9(
  ///       Stream.value('a'),
  ///       Stream.value('b'),
  ///       Stream.value('c'),
  ///       Stream.value('d'),
  ///       Stream.value('e'),
  ///       Stream.value('f'),
  ///       Stream.value('g'),
  ///       Stream.value('h'),
  ///       Stream.fromIterable(['i', 'i']),
  ///       (a, b, c, d, e, f, g, h, i) => a + b + c + d + e + f + g + h + i)
  ///     .listen(print); //prints 'abcdefghi', 'abcdefghi'
  static Stream<T> combineLatest9<A, B, C, D, E, F, G, H, I, T>(
          Stream<A> streamA,
          Stream<B> streamB,
          Stream<C> streamC,
          Stream<D> streamD,
          Stream<E> streamE,
          Stream<F> streamF,
          Stream<G> streamG,
          Stream<H> streamH,
          Stream<I> streamI,
          T Function(A a, B b, C c, D d, E e, F f, G g, H h, I i) combiner) =>
      CombineLatestStream.combine9(
        streamA,
        streamB,
        streamC,
        streamD,
        streamE,
        streamF,
        streamG,
        streamH,
        streamI,
        combiner,
      );

  /// Concatenates all of the specified stream sequences, as long as the
  /// previous stream sequence terminated successfully.
  ///
  /// It does this by subscribing to each stream one by one, emitting all items
  /// and completing before subscribing to the next stream.
  ///
  /// [Interactive marble diagram](http://rxmarbles.com/#concat)
  ///
  /// ### Example
  ///
  ///     Rx.concat([
  ///       Stream.value(1),
  ///       Rx.timer(2, Duration(days: 1)),
  ///       Stream.value(3)
  ///     ])
  ///     .listen(print); // prints 1, 2, 3
  static Stream<T> concat<T>(Iterable<Stream<T>> streams) =>
      ConcatStream<T>(streams);

  /// Concatenates all of the specified stream sequences, as long as the
  /// previous stream sequence terminated successfully.
  ///
  /// In the case of concatEager, rather than subscribing to one stream after
  /// the next, all streams are immediately subscribed to. The events are then
  /// captured and emitted at the correct time, after the previous stream has
  /// finished emitting items.
  ///
  /// [Interactive marble diagram](http://rxmarbles.com/#concat)
  ///
  /// ### Example
  ///
  ///     Rx.concatEager([
  ///       Stream.value(1),
  ///       Rx.timer(2, Duration(days: 1)),
  ///       Stream.value(3)
  ///     ])
  ///     .listen(print); // prints 1, 2, 3
  static Stream<T> concatEager<T>(Iterable<Stream<T>> streams) =>
      ConcatEagerStream<T>(streams);

  /// The defer factory waits until an observer subscribes to it, and then it
  /// creates a [Stream] with the given factory function.
  ///
  /// In some circumstances, waiting until the last minute (that is, until
  /// subscription time) to generate the Stream can ensure that this
  /// Stream contains the freshest data.
  ///
  /// By default, DeferStreams are single-subscription. However, it's possible
  /// to make them reusable.
  ///
  /// ### Example
  ///
  ///     Rx.defer(() => Stream.value(1))
  ///       .listen(print); //prints 1
  static Stream<T> defer<T>(Stream<T> Function() streamFactory,
          {bool reusable = false}) =>
      DeferStream<T>(streamFactory, reusable: reusable);

  ///  Creates a [Stream] where all last events of existing stream(s) are piped
  ///  through a sink-transformation.
  ///
  /// This operator is best used when you have a group of streams
  /// and only care about the final emitted value of each.
  /// One common use case for this is if you wish to issue multiple
  /// requests on page load (or some other event)
  /// and only want to take action when a response has been received for all.
  ///
  /// In this way it is similar to how you might use [Future].wait.
  ///
  /// Be aware that if any of the inner streams supplied to forkJoin error
  /// you will lose the value of any other streams that would or have already
  /// completed if you do not catch the error correctly on the inner stream.
  ///
  /// If you are only concerned with all inner streams completing
  /// successfully you can catch the error on the outside.
  /// It's also worth noting that if you have an stream
  /// that emits more than one item, and you are concerned with the previous
  /// emissions forkJoin is not the correct choice.
  ///
  /// In these cases you may better off with an operator like combineLatest or zip.
  ///
  /// ### Example
  ///
  ///    Rx.forkJoin([
  ///      Stream.value('a'),
  ///      Stream.fromIterable(['b', 'c', 'd'])
  ///    ], (list) => list.join(', '))
  ///    .listen(print); // prints 'a, d'
  static Stream<R> forkJoin<T, R>(
          Iterable<Stream<T>> streams, R Function(List<T> values) combiner) =>
      ForkJoinStream<T, R>(streams, combiner);

  /// Merges the given Streams into a single Stream that emits a List of the
  /// last values emitted by the source stream(s). This is helpful when you need to
  /// forkJoin a dynamic number of Streams.
  ///
  /// ### Example
  ///
  ///     Rx.forkJoinList([
  ///       Stream.value(1),
  ///       Stream.fromIterable([0, 1, 2]),
  ///     ])
  ///     .listen(print); // prints [1, 2]
  static Stream<List<T>> forkJoinList<T>(Iterable<Stream<T>> streams) =>
      ForkJoinStream.list<T>(streams);

  /// Merges the given Streams into a single Stream sequence by using the
  /// [combiner] function when all of the stream sequences emits their
  /// last item.
  ///
  /// ### Example
  ///
  ///     Rx.forkJoin2(
  ///       Stream.value(1),
  ///       Stream.fromIterable([0, 1, 2]),
  ///       (a, b) => a + b)
  ///     .listen(print); //prints 3
  static Stream<T> forkJoin2<A, B, T>(Stream<A> streamA, Stream<B> streamB,
          T Function(A a, B b) combiner) =>
      ForkJoinStream.combine2(streamA, streamB, combiner);

  /// Merges the given Streams into a single Stream sequence by using the
  /// [combiner] function when all of the stream sequences emits their
  /// last item.
  ///
  /// ### Example
  ///
  ///     Rx.forkJoin3(
  ///       Stream.value('a'),
  ///       Stream.value('b'),
  ///       Stream.fromIterable(['c', 'd']),
  ///       (a, b, c) => a + b + c)
  ///     .listen(print); //prints 'abd'
  static Stream<T> forkJoin3<A, B, C, T>(Stream<A> streamA, Stream<B> streamB,
          Stream<C> streamC, T Function(A a, B b, C c) combiner) =>
      ForkJoinStream.combine3(streamA, streamB, streamC, combiner);

  /// Merges the given Streams into a single Stream sequence by using the
  /// [combiner] function when all of the stream sequences emits their
  /// last item.
  ///
  /// ### Example
  ///
  ///     Rx.forkJoin4(
  ///       Stream.value('a'),
  ///       Stream.value('b'),
  ///       Stream.value('c'),
  ///       Stream.fromIterable(['d', 'e']),
  ///       (a, b, c, d) => a + b + c + d)
  ///     .listen(print); //prints 'abce'
  static Stream<T> forkJoin4<A, B, C, D, T>(
          Stream<A> streamA,
          Stream<B> streamB,
          Stream<C> streamC,
          Stream<D> streamD,
          T Function(A a, B b, C c, D d) combiner) =>
      ForkJoinStream.combine4(streamA, streamB, streamC, streamD, combiner);

  /// Merges the given Streams into a single Stream sequence by using the
  /// [combiner] function when all of the stream sequences emits their
  /// last item.
  ///
  /// ### Example
  ///
  ///     Rx.forkJoin5(
  ///       Stream.value('a'),
  ///       Stream.value('b'),
  ///       Stream.value('c'),
  ///       Stream.value('d'),
  ///       Stream.fromIterable(['e', 'f']),
  ///       (a, b, c, d, e) => a + b + c + d + e)
  ///     .listen(print); //prints 'abcdf'
  static Stream<T> forkJoin5<A, B, C, D, E, T>(
          Stream<A> streamA,
          Stream<B> streamB,
          Stream<C> streamC,
          Stream<D> streamD,
          Stream<E> streamE,
          T Function(A a, B b, C c, D d, E e) combiner) =>
      ForkJoinStream.combine5(
          streamA, streamB, streamC, streamD, streamE, combiner);

  /// Merges the given Streams into a single Stream sequence by using the
  /// [combiner] function when all of the stream sequences emits their
  /// last item.
  ///
  /// ### Example
  ///
  ///     Rx.forkJoin6(
  ///       Stream.value('a'),
  ///       Stream.value('b'),
  ///       Stream.value('c'),
  ///       Stream.value('d'),
  ///       Stream.value('e'),
  ///       Stream.fromIterable(['f', 'g']),
  ///       (a, b, c, d, e, f) => a + b + c + d + e + f)
  ///     .listen(print); //prints 'abcdeg'
  static Stream<T> forkJoin6<A, B, C, D, E, F, T>(
          Stream<A> streamA,
          Stream<B> streamB,
          Stream<C> streamC,
          Stream<D> streamD,
          Stream<E> streamE,
          Stream<F> streamF,
          T Function(A a, B b, C c, D d, E e, F f) combiner) =>
      ForkJoinStream.combine6(
          streamA, streamB, streamC, streamD, streamE, streamF, combiner);

  /// Merges the given Streams into a single Stream sequence by using the
  /// [combiner] function when all of the stream sequences emits their
  /// last item.
  ///
  /// ### Example
  ///
  ///     Rx.forkJoin7(
  ///       Stream.value('a'),
  ///       Stream.value('b'),
  ///       Stream.value('c'),
  ///       Stream.value('d'),
  ///       Stream.value('e'),
  ///       Stream.value('f'),
  ///       Stream.fromIterable(['g', 'h']),
  ///       (a, b, c, d, e, f, g) => a + b + c + d + e + f + g)
  ///     .listen(print); //prints 'abcdefh'
  static Stream<T> forkJoin7<A, B, C, D, E, F, G, T>(
          Stream<A> streamA,
          Stream<B> streamB,
          Stream<C> streamC,
          Stream<D> streamD,
          Stream<E> streamE,
          Stream<F> streamF,
          Stream<G> streamG,
          T Function(A a, B b, C c, D d, E e, F f, G g) combiner) =>
      ForkJoinStream.combine7(streamA, streamB, streamC, streamD, streamE,
          streamF, streamG, combiner);

  /// Merges the given Streams into a single Stream sequence by using the
  /// [combiner] function when all of the stream sequences emits their
  /// last item.
  ///
  /// ### Example
  ///
  ///     Rx.forkJoin8(
  ///       Stream.value('a'),
  ///       Stream.value('b'),
  ///       Stream.value('c'),
  ///       Stream.value('d'),
  ///       Stream.value('e'),
  ///       Stream.value('f'),
  ///       Stream.value('g'),
  ///       Stream.fromIterable(['h', 'i']),
  ///       (a, b, c, d, e, f, g, h) => a + b + c + d + e + f + g + h)
  ///     .listen(print); //prints 'abcdefgi'
  static Stream<T> forkJoin8<A, B, C, D, E, F, G, H, T>(
          Stream<A> streamA,
          Stream<B> streamB,
          Stream<C> streamC,
          Stream<D> streamD,
          Stream<E> streamE,
          Stream<F> streamF,
          Stream<G> streamG,
          Stream<H> streamH,
          T Function(A a, B b, C c, D d, E e, F f, G g, H h) combiner) =>
      ForkJoinStream.combine8(
        streamA,
        streamB,
        streamC,
        streamD,
        streamE,
        streamF,
        streamG,
        streamH,
        combiner,
      );

  /// Merges the given Streams into a single Stream sequence by using the
  /// [combiner] function when all of the stream sequences emits their
  /// last item.
  ///
  /// ### Example
  ///
  ///     Rx.forkJoin9(
  ///       Stream.value('a'),
  ///       Stream.value('b'),
  ///       Stream.value('c'),
  ///       Stream.value('d'),
  ///       Stream.value('e'),
  ///       Stream.value('f'),
  ///       Stream.value('g'),
  ///       Stream.value('h'),
  ///       Stream.fromIterable(['i', 'j']),
  ///       (a, b, c, d, e, f, g, h, i) => a + b + c + d + e + f + g + h + i)
  ///     .listen(print); //prints 'abcdefghj'
  static Stream<T> forkJoin9<A, B, C, D, E, F, G, H, I, T>(
          Stream<A> streamA,
          Stream<B> streamB,
          Stream<C> streamC,
          Stream<D> streamD,
          Stream<E> streamE,
          Stream<F> streamF,
          Stream<G> streamG,
          Stream<H> streamH,
          Stream<I> streamI,
          T Function(A a, B b, C c, D d, E e, F f, G g, H h, I i) combiner) =>
      ForkJoinStream.combine9(
        streamA,
        streamB,
        streamC,
        streamD,
        streamE,
        streamF,
        streamG,
        streamH,
        streamI,
        combiner,
      );

  /// Flattens the items emitted by the given [streams] into a single Stream
  /// sequence.
  ///
  /// [Interactive marble diagram](http://rxmarbles.com/#merge)
  ///
  /// ### Example
  ///
  ///     Rx.merge([
  ///       Rx.timer(1, Duration(days: 10)),
  ///       Stream.value(2)
  ///     ])
  ///     .listen(print); // prints 2, 1
  static Stream<T> merge<T>(Iterable<Stream<T>> streams) =>
      MergeStream<T>(streams);

  /// Returns a non-terminating stream sequence, which can be used to denote
  /// an infinite duration.
  ///
  /// The never operator is one with very specific and limited behavior. These
  /// are useful for testing purposes, and sometimes also for combining with
  /// other Streams or as parameters to operators that expect other
  /// Streams as parameters.
  ///
  /// ### Example
  ///
  ///     Rx.never().listen(print); // Neither prints nor terminates
  static Stream<T> never<T>() => NeverStream<T>();

  /// Given two or more source [streams], emit all of the items from only
  /// the first of these [streams] to emit an item or notification.
  ///
  /// [Interactive marble diagram](http://rxmarbles.com/#amb)
  ///
  /// ### Example
  ///
  ///     Rx.race([
  ///       Rx.timer(1, Duration(days: 1)),
  ///       Rx.timer(2, Duration(days: 2)),
  ///       Rx.timer(3, Duration(seconds: 1))
  ///     ]).listen(print); // prints 3
  static Stream<T> race<T>(Iterable<Stream<T>> streams) =>
      RaceStream<T>(streams);

  /// Returns a [Stream] that emits a sequence of Integers within a specified
  /// range.
  ///
  /// ### Example
  ///
  ///     Rx.range(1, 3).listen((i) => print(i); // Prints 1, 2, 3
  ///
  ///     Rx.range(3, 1).listen((i) => print(i); // Prints 3, 2, 1
  static Stream<int> range(int startInclusive, int endInclusive) =>
      RangeStream(startInclusive, endInclusive);

  /// Creates a [Stream] that will recreate and re-listen to the source
  /// Stream the specified number of times until the [Stream] terminates
  /// successfully.
  ///
  /// If [count] is not specified, it repeats indefinitely.
  ///
  /// ### Example
  ///
  ///     RepeatStream((int repeatCount) =>
  ///       Stream.value('repeat index: $repeatCount'), 3)
  ///         .listen((i) => print(i); // Prints 'repeat index: 0, repeat index: 1, repeat index: 2'
  static Stream<T> repeat<T>(Stream<T> Function(int repeatIndex) streamFactory,
          [int count]) =>
      RepeatStream<T>(streamFactory, count);

  /// Creates a [Stream] that will recreate and re-listen to the source
  /// Stream the specified number of times until the Stream terminates
  /// successfully.
  ///
  /// If the retry count is not specified, it retries indefinitely. If the retry
  /// count is met, but the Stream has not terminated successfully, a
  /// [RetryError] will be thrown. The RetryError will contain all of the Errors
  /// and StackTraces that caused the failure.
  ///
  /// ### Example
  ///
  ///     Rx.retry(() { Stream.value(1); })
  ///         .listen((i) => print(i); // Prints 1
  ///
  ///     Rx
  ///        .retry(() {
  ///          Stream.value(1).concatWith([Stream.error(Error())]);
  ///        }, 1)
  ///        .listen(print, onError: (e, s) => print(e); // Prints 1, 1, RetryError
  static Stream<T> retry<T>(Stream<T> Function() streamFactory, [int count]) =>
      RetryStream<T>(streamFactory, count);

  /// Creates a Stream that will recreate and re-listen to the source
  /// Stream when the notifier emits a new value. If the source Stream
  /// emits an error or it completes, the Stream terminates.
  ///
  /// If the [retryWhenFactory] emits an error a [RetryError] will be
  /// thrown. The RetryError will contain all of the [Error]s and
  /// [StackTrace]s that caused the failure.
  ///
  /// ### Basic Example
  /// ```dart
  /// RetryWhenStream<int>(
  ///   () => Stream<int>.fromIterable(<int>[1]),
  ///   (dynamic error, StackTrace s) => throw error,
  /// ).listen(print); // Prints 1
  /// ```
  ///
  /// ### Periodic Example
  /// ```dart
  /// RetryWhenStream<int>(
  ///   () => Stream<int>
  ///       .periodic(const Duration(seconds: 1), (int i) => i)
  ///       .map((int i) => i == 2 ? throw 'exception' : i),
  ///   (dynamic e, StackTrace s) {
  ///     return Rx.timer('random value', const Duration(milliseconds: 200);
  ///   },
  /// ).take(4).listen(print); // Prints 0, 1, 0, 1
  /// ```
  ///
  /// ### Complex Example
  /// ```dart
  /// bool errorHappened = false;
  /// RetryWhenStream(
  ///   () => Stream
  ///       .periodic(const Duration(seconds: 1), (i) => i)
  ///       .map((i) {
  ///         if (i == 3 && !errorHappened) {
  ///           throw 'We can take this. Please restart.';
  ///         } else if (i == 4) {
  ///           throw 'It\'s enough.';
  ///         } else {
  ///           return i;
  ///         }
  ///       }),
  ///   (e, s) {
  ///     errorHappened = true;
  ///     if (e == 'We can take this. Please restart.') {
  ///       return Stream.value('Ok. Here you go!');
  ///     } else {
  ///       return Stream.error(e);
  ///     }
  ///   },
  /// ).listen(
  ///   print,
  ///   onError: (e, s) => print(e),
  /// ); // Prints 0, 1, 2, 0, 1, 2, 3, RetryError
  /// ```
  static Stream<T> retryWhen<T>(
    Stream<T> Function() streamFactory,
    Stream<void> Function(dynamic error, StackTrace stack) retryWhenFactory,
  ) =>
      RetryWhenStream<T>(streamFactory, retryWhenFactory);

  /// Determine whether two Streams emit the same sequence of items.
  /// You can provide an optional [equals] handler to determine equality.
  ///
  /// [Interactive marble diagram](https://rxmarbles.com/#sequenceEqual)
  ///
  /// ### Example
  ///
  ///     Rx.sequenceEqual([
  ///       Stream.fromIterable([1, 2, 3, 4, 5]),
  ///       Stream.fromIterable([1, 2, 3, 4, 5])
  ///     ])
  ///     .listen(print); // prints true
  static Stream<bool> sequenceEqual<A, B>(Stream<A> stream, Stream<B> other,
          {bool Function(A a, B b) equals}) =>
      SequenceEqualStream<A, B>(stream, other, equals: equals);

  /// Convert a Stream that emits Streams (aka a 'Higher Order Stream') into a
  /// single Stream that emits the items emitted by the most-recently-emitted of
  /// those Streams.
  ///
  /// This Stream will unsubscribe from the previously-emitted Stream when
  /// a new Stream is emitted from the source Stream and subscribe to the new
  /// Stream.
  ///
  /// ### Example
  ///
  /// ```dart
  /// final switchLatestStream = SwitchLatestStream<String>(
  ///   Stream.fromIterable(<Stream<String>>[
  ///     Rx.timer('A', Duration(seconds: 2)),
  ///     Rx.timer('B', Duration(seconds: 1)),
  ///     Stream.value('C'),
  ///   ]),
  /// );
  ///
  /// // Since the first two Streams do not emit data for 1-2 seconds, and the
  /// // 3rd Stream will be emitted before that time, only data from the 3rd
  /// // Stream will be emitted to the listener.
  /// switchLatestStream.listen(print); // prints 'C'
  /// ```
  static Stream<T> switchLatest<T>(Stream<Stream<T>> streams) =>
      SwitchLatestStream<T>(streams);

  /// Emits the given value after a specified amount of time.
  ///
  /// ### Example
  ///
  ///     Rx.timer('hi', Duration(minutes: 1))
  ///         .listen((i) => print(i); // print 'hi' after 1 minute
  static Stream<T> timer<T>(T value, Duration duration) =>
      (TimerStream<T>(value, duration));

  /// Merges the specified streams into one stream sequence using the given
  /// zipper function whenever all of the stream sequences have produced
  /// an element at a corresponding index.
  ///
  /// It applies this function in strict sequence, so the first item emitted by
  /// the new Stream will be the result of the function applied to the first
  /// item emitted by Stream #1 and the first item emitted by Stream #2;
  /// the second item emitted by the new ZipStream will be the result of
  /// the function applied to the second item emitted by Stream #1 and the
  /// second item emitted by Stream #2; and so forth. It will only emit as
  /// many items as the number of items emitted by the source Stream that
  /// emits the fewest items.
  ///
  /// [Interactive marble diagram](http://rxmarbles.com/#zip)
  ///
  /// ### Example
  ///
  ///     Rx.zip2(
  ///       Stream.value('Hi '),
  ///       Stream.fromIterable(['Friend', 'Dropped']),
  ///       (a, b) => a + b)
  ///     .listen(print); // prints 'Hi Friend'
  static Stream<T> zip2<A, B, T>(
          Stream<A> streamA, Stream<B> streamB, T Function(A a, B b) zipper) =>
      ZipStream.zip2(streamA, streamB, zipper);

  /// Merges the iterable streams into one stream sequence using the given
  /// zipper function whenever all of the stream sequences have produced
  /// an element at a corresponding index.
  ///
  /// It applies this function in strict sequence, so the first item emitted by
  /// the new Stream will be the result of the function applied to the first
  /// item emitted by Stream #1 and the first item emitted by Stream #2;
  /// the second item emitted by the new ZipStream will be the result of
  /// the function applied to the second item emitted by Stream #1 and the
  /// second item emitted by Stream #2; and so forth. It will only emit as
  /// many items as the number of items emitted by the source Stream that
  /// emits the fewest items.
  ///
  /// [Interactive marble diagram](http://rxmarbles.com/#zip)
  ///
  /// ### Example
  ///
  ///     Rx.zip(
  ///       [
  ///         Stream.value('Hi '),
  ///         Stream.fromIterable(['Friend', 'Dropped']),
  ///       ],
  ///       (values) => values.first + values.last
  ///     )
  ///     .listen(print); // prints 'Hi Friend'
  static Stream<R> zip<T, R>(
          Iterable<Stream<T>> streams, R Function(List<T> values) zipper) =>
      ZipStream(streams, zipper);

  /// Merges the iterable streams into one stream sequence using the given
  /// zipper function whenever all of the stream sequences have produced
  /// an element at a corresponding index.
  ///
  /// It applies this function in strict sequence, so the first item emitted by
  /// the new Stream will be the result of the function applied to the first
  /// item emitted by Stream #1 and the first item emitted by Stream #2;
  /// the second item emitted by the new ZipStream will be the result of
  /// the function applied to the second item emitted by Stream #1 and the
  /// second item emitted by Stream #2; and so forth. It will only emit as
  /// many items as the number of items emitted by the source Stream that
  /// emits the fewest items.
  ///
  /// [Interactive marble diagram](http://rxmarbles.com/#zip)
  ///
  /// ### Example
  ///
  ///     Rx.zipList(
  ///       [
  ///         Stream.value('Hi '),
  ///         Stream.fromIterable(['Friend', 'Dropped']),
  ///       ],
  ///     )
  ///     .listen(print); // prints ['Hi ', 'Friend']
  static Stream<List<T>> zipList<T>(Iterable<Stream<T>> streams) =>
      ZipStream.list(streams);

  /// Merges the specified streams into one stream sequence using the given
  /// zipper function whenever all of the stream sequences have produced
  /// an element at a corresponding index.
  ///
  /// It applies this function in strict sequence, so the first item emitted by
  /// the new Stream will be the result of the function applied to the first
  /// item emitted by Stream #1 and the first item emitted by Stream #2;
  /// the second item emitted by the new ZipStream will be the result of
  /// the function applied to the second item emitted by Stream #1 and the
  /// second item emitted by Stream #2; and so forth. It will only emit as
  /// many items as the number of items emitted by the source Stream that
  /// emits the fewest items.
  ///
  /// [Interactive marble diagram](http://rxmarbles.com/#zip)
  ///
  /// ### Example
  ///
  ///     Rx.zip3(
  ///       Stream.value('a'),
  ///       Stream.value('b'),
  ///       Stream.fromIterable(['c', 'dropped']),
  ///       (a, b, c) => a + b + c)
  ///     .listen(print); //prints 'abc'
  static Stream<T> zip3<A, B, C, T>(Stream<A> streamA, Stream<B> streamB,
          Stream<C> streamC, T Function(A a, B b, C c) zipper) =>
      ZipStream.zip3(streamA, streamB, streamC, zipper);

  /// Merges the specified streams into one stream sequence using the given
  /// zipper function whenever all of the stream sequences have produced
  /// an element at a corresponding index.
  ///
  /// It applies this function in strict sequence, so the first item emitted by
  /// the new Stream will be the result of the function applied to the first
  /// item emitted by Stream #1 and the first item emitted by Stream #2;
  /// the second item emitted by the new ZipStream will be the result of
  /// the function applied to the second item emitted by Stream #1 and the
  /// second item emitted by Stream #2; and so forth. It will only emit as
  /// many items as the number of items emitted by the source Stream that
  /// emits the fewest items.
  ///
  /// [Interactive marble diagram](http://rxmarbles.com/#zip)
  ///
  /// ### Example
  ///
  ///     Rx.zip4(
  ///       Stream.value('a'),
  ///       Stream.value('b'),
  ///       Stream.value('c'),
  ///       Stream.fromIterable(['d', 'dropped']),
  ///       (a, b, c, d) => a + b + c + d)
  ///     .listen(print); //prints 'abcd'
  static Stream<T> zip4<A, B, C, D, T>(
          Stream<A> streamA,
          Stream<B> streamB,
          Stream<C> streamC,
          Stream<D> streamD,
          T Function(A a, B b, C c, D d) zipper) =>
      ZipStream.zip4(streamA, streamB, streamC, streamD, zipper);

  /// Merges the specified streams into one stream sequence using the given
  /// zipper function whenever all of the stream sequences have produced
  /// an element at a corresponding index.
  ///
  /// It applies this function in strict sequence, so the first item emitted by
  /// the new Stream will be the result of the function applied to the first
  /// item emitted by Stream #1 and the first item emitted by Stream #2;
  /// the second item emitted by the new ZipStream will be the result of
  /// the function applied to the second item emitted by Stream #1 and the
  /// second item emitted by Stream #2; and so forth. It will only emit as
  /// many items as the number of items emitted by the source Stream that
  /// emits the fewest items.
  ///
  /// [Interactive marble diagram](http://rxmarbles.com/#zip)
  ///
  /// ### Example
  ///
  ///     Rx.zip5(
  ///       Stream.value('a'),
  ///       Stream.value('b'),
  ///       Stream.value('c'),
  ///       Stream.value('d'),
  ///       Stream.fromIterable(['e', 'dropped']),
  ///       (a, b, c, d, e) => a + b + c + d + e)
  ///     .listen(print); //prints 'abcde'
  static Stream<T> zip5<A, B, C, D, E, T>(
          Stream<A> streamA,
          Stream<B> streamB,
          Stream<C> streamC,
          Stream<D> streamD,
          Stream<E> streamE,
          T Function(A a, B b, C c, D d, E e) zipper) =>
      ZipStream.zip5(streamA, streamB, streamC, streamD, streamE, zipper);

  /// Merges the specified streams into one stream sequence using the given
  /// zipper function whenever all of the stream sequences have produced
  /// an element at a corresponding index.
  ///
  /// It applies this function in strict sequence, so the first item emitted by
  /// the new Stream will be the result of the function applied to the first
  /// item emitted by Stream #1 and the first item emitted by Stream #2;
  /// the second item emitted by the new ZipStream will be the result of
  /// the function applied to the second item emitted by Stream #1 and the
  /// second item emitted by Stream #2; and so forth. It will only emit as
  /// many items as the number of items emitted by the source Stream that
  /// emits the fewest items.
  ///
  /// [Interactive marble diagram](http://rxmarbles.com/#zip)
  ///
  /// ### Example
  ///
  ///     Rx.zip6(
  ///       Stream.value('a'),
  ///       Stream.value('b'),
  ///       Stream.value('c'),
  ///       Stream.value('d'),
  ///       Stream.value('e'),
  ///       Stream.fromIterable(['f', 'dropped']),
  ///       (a, b, c, d, e, f) => a + b + c + d + e + f)
  ///     .listen(print); //prints 'abcdef'
  static Stream<T> zip6<A, B, C, D, E, F, T>(
          Stream<A> streamA,
          Stream<B> streamB,
          Stream<C> streamC,
          Stream<D> streamD,
          Stream<E> streamE,
          Stream<F> streamF,
          T Function(A a, B b, C c, D d, E e, F f) zipper) =>
      ZipStream.zip6(
        streamA,
        streamB,
        streamC,
        streamD,
        streamE,
        streamF,
        zipper,
      );

  /// Merges the specified streams into one stream sequence using the given
  /// zipper function whenever all of the stream sequences have produced
  /// an element at a corresponding index.
  ///
  /// It applies this function in strict sequence, so the first item emitted by
  /// the new Stream will be the result of the function applied to the first
  /// item emitted by Stream #1 and the first item emitted by Stream #2;
  /// the second item emitted by the new ZipStream will be the result of
  /// the function applied to the second item emitted by Stream #1 and the
  /// second item emitted by Stream #2; and so forth. It will only emit as
  /// many items as the number of items emitted by the source Stream that
  /// emits the fewest items.
  ///
  /// [Interactive marble diagram](http://rxmarbles.com/#zip)
  ///
  /// ### Example
  ///
  ///     Rx.zip7(
  ///       Stream.value('a'),
  ///       Stream.value('b'),
  ///       Stream.value('c'),
  ///       Stream.value('d'),
  ///       Stream.value('e'),
  ///       Stream.value('f'),
  ///       Stream.fromIterable(['g', 'dropped']),
  ///       (a, b, c, d, e, f, g) => a + b + c + d + e + f + g)
  ///     .listen(print); //prints 'abcdefg'
  static Stream<T> zip7<A, B, C, D, E, F, G, T>(
          Stream<A> streamA,
          Stream<B> streamB,
          Stream<C> streamC,
          Stream<D> streamD,
          Stream<E> streamE,
          Stream<F> streamF,
          Stream<G> streamG,
          T Function(A a, B b, C c, D d, E e, F f, G g) zipper) =>
      ZipStream.zip7(
        streamA,
        streamB,
        streamC,
        streamD,
        streamE,
        streamF,
        streamG,
        zipper,
      );

  /// Merges the specified streams into one stream sequence using the given
  /// zipper function whenever all of the stream sequences have produced
  /// an element at a corresponding index.
  ///
  /// It applies this function in strict sequence, so the first item emitted by
  /// the new Stream will be the result of the function applied to the first
  /// item emitted by Stream #1 and the first item emitted by Stream #2;
  /// the second item emitted by the new ZipStream will be the result of
  /// the function applied to the second item emitted by Stream #1 and the
  /// second item emitted by Stream #2; and so forth. It will only emit as
  /// many items as the number of items emitted by the source Stream that
  /// emits the fewest items.
  ///
  /// [Interactive marble diagram](http://rxmarbles.com/#zip)
  ///
  /// ### Example
  ///
  ///     Rx.zip8(
  ///       Stream.value('a'),
  ///       Stream.value('b'),
  ///       Stream.value('c'),
  ///       Stream.value('d'),
  ///       Stream.value('e'),
  ///       Stream.value('f'),
  ///       Stream.value('g'),
  ///       Stream.fromIterable(['h', 'dropped']),
  ///       (a, b, c, d, e, f, g, h) => a + b + c + d + e + f + g + h)
  ///     .listen(print); //prints 'abcdefgh'
  static Stream<T> zip8<A, B, C, D, E, F, G, H, T>(
          Stream<A> streamA,
          Stream<B> streamB,
          Stream<C> streamC,
          Stream<D> streamD,
          Stream<E> streamE,
          Stream<F> streamF,
          Stream<G> streamG,
          Stream<H> streamH,
          T Function(A a, B b, C c, D d, E e, F f, G g, H h) zipper) =>
      ZipStream.zip8(
        streamA,
        streamB,
        streamC,
        streamD,
        streamE,
        streamF,
        streamG,
        streamH,
        zipper,
      );

  /// Merges the specified streams into one stream sequence using the given
  /// zipper function whenever all of the stream sequences have produced
  /// an element at a corresponding index.
  ///
  /// It applies this function in strict sequence, so the first item emitted by
  /// the new Stream will be the result of the function applied to the first
  /// item emitted by Stream #1 and the first item emitted by Stream #2;
  /// the second item emitted by the new ZipStream will be the result of
  /// the function applied to the second item emitted by Stream #1 and the
  /// second item emitted by Stream #2; and so forth. It will only emit as
  /// many items as the number of items emitted by the source Stream that
  /// emits the fewest items.
  ///
  /// [Interactive marble diagram](http://rxmarbles.com/#zip)
  ///
  /// ### Example
  ///
  ///     Rx.zip9(
  ///       Stream.value('a'),
  ///       Stream.value('b'),
  ///       Stream.value('c'),
  ///       Stream.value('d'),
  ///       Stream.value('e'),
  ///       Stream.value('f'),
  ///       Stream.value('g'),
  ///       Stream.value('h'),
  ///       Stream.fromIterable(['i', 'dropped']),
  ///       (a, b, c, d, e, f, g, h, i) => a + b + c + d + e + f + g + h + i)
  ///     .listen(print); //prints 'abcdefghi'
  static Stream<T> zip9<A, B, C, D, E, F, G, H, I, T>(
          Stream<A> streamA,
          Stream<B> streamB,
          Stream<C> streamC,
          Stream<D> streamD,
          Stream<E> streamE,
          Stream<F> streamF,
          Stream<G> streamG,
          Stream<H> streamH,
          Stream<I> streamI,
          T Function(A a, B b, C c, D d, E e, F f, G g, H h, I i) zipper) =>
      ZipStream.zip9(
        streamA,
        streamB,
        streamC,
        streamD,
        streamE,
        streamF,
        streamG,
        streamH,
        streamI,
        zipper,
      );
}
