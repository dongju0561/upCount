import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    //UI와 코드 바인딩
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var increaseButton: UIButton!

    //메모리 관리를 위한 객체 선언
    private let disposeBag = DisposeBag()
    private var number = BehaviorRelay<Int>(value: 0)

    override func viewDidLoad() {
        super.viewDidLoad()

        // increaseButton의 탭 이벤트를 감지하여 number를 1씩 증가
        increaseButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.number.accept(self.number.value + 1)
            })
            .disposed(by: disposeBag)

        // number의 변화를 감지하여 레이블 업데이트
        number
            .map { "\($0)" }
            .bind(to: numberLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
