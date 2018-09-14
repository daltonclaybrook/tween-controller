import TweenController
import UIKit

class StartViewController: UIViewController, TutorialViewController {
    //swiftlint:disable private_outlet
    @IBOutlet var containerView: UIView!
    @IBOutlet var buttonsContainerView: UIView!
    @IBOutlet var pageControl: UIPageControl!
    //swiftlint:enable private_outlet

    private var hasAppeared = false
    private var tweenController: TweenController!
    private var scrollView: UIScrollView!

    // MARK: - Superclass

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !hasAppeared {
            hasAppeared = true

            let (controller, scrollView) = TutorialBuilder.buildWithContainerViewController(self)
            tweenController = controller
            self.scrollView = scrollView
            self.scrollView.delegate = self
        }
    }

    // MARK: - Private

    private func updatePageControl() {
        pageControl.currentPage = Int(round(scrollView.contentOffset.x / containerView.frame.width))
    }
}

extension StartViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tweenController.update(progress: Double(scrollView.twc_horizontalPageProgress))
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updatePageControl()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            updatePageControl()
        }
    }
}
