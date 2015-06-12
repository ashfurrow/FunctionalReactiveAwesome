import RxSwift

func and(observable: Observable<(Bool, Bool)>) -> Observable<Bool> {
    return observable
        >- map { (thing) -> Bool in
            return thing.0 && thing.1
        }
}

func combineLatest(source1: Observable<Bool>, source2: Observable<Bool>) -> Observable<(Bool, Bool)> {
    return combineLatest(source1, source2) { (a: Bool, b: Bool) -> (Bool, Bool) in
        return (a, b)
    }
}


