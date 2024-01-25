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

        /*
         increaseButton의 탭 이벤트를 감지하여 number를 1씩 증가
         increaseButton이 옵저버블(obseverable)이 됩니다. .subscribe라는 메소드를 사용해서 해당 옵저버블을 구독합니다. 여기서 구독이라고 함은 옵저버블의 이벤트를 모니터링하면서 이벤트가 발생할때 동작하는 것을 정의해줍니다.
        */
        increaseButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.number.accept(self.number.value + 1)
            })
            .disposed(by: disposeBag)

        // number의 변화를 감지하여 레이블 업데이트
        number
            //map 메소드로 전달받은 값을 정수형에서 문자열로 타입 변환
            .map { "\($0)" }
        
            //BehaviorRelay 타입을 가진 number 변수와 numberLabel과 바인딩
            //number 변수의 값이 변경됨에 따라 UI업데이트 진행
            .bind(to: numberLabel.rx.text)
        
            .disposed(by: disposeBag)
    }
}
