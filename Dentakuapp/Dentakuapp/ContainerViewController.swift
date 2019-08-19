//
//  ContainerViewController.swift
//  Dentakuapp
//
//  Created by 濱田和孝 on 2019/08/10.
//  Copyright © 2019 jon濱田和孝. All rights reserved.


import Foundation
import UIKit

class ContainerViewController:UIViewController{

    @IBOutlet weak var button_close: UIButton!
    @IBOutlet private weak var mainScrollView: UIScrollView!
    @IBOutlet private weak var pageControl: UIPageControl!
    
    /// ポップアップ画面（モーダルビュー）のページ数。挿入する画像枚数と等しい。
    private let numberOfPages = 6
    
    /// 現在のページインデックス
    private var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageControl()
    }
    
   override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
      }
    
    //ポップアップ画面を閉じる。
    @IBAction func close_expain(_ sender: Any) {
       self.dismiss(animated: false, completion: nil)
    }
    

    // ポップアップの外側をタップした時にポップアップを閉じる→なぜか機能しないため後日修正
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        var tapLocation: CGPoint = CGPoint()
        // タッチイベントを取得する
        let touch = touches.first
        // タップした座標を取得する
        tapLocation = touch!.location(in: self.view)
        
        let popUpView: UIView = self.view.viewWithTag(100)! as UIView
        
        if !popUpView.frame.contains(tapLocation) {
            self.dismiss(animated: false, completion: nil)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //閉じるボタンを丸くする
        button_close.layer.cornerRadius = button_close.frame.size.width * 0.5
        
        setupMainScrollView()
        (0..<numberOfPages).forEach { page in
            let subScrollView = generateSubScrollView(at: page)
            mainScrollView.addSubview(subScrollView)
            let imageView = generateImageView(at: page)
            subScrollView.addSubview(imageView)
        }
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPage = currentPage
        // タップされたときのイベントハンドリングを設定
        pageControl.addTarget(
            self,
            action: #selector(didValueChangePageControl),
            for: .valueChanged
        )
    }
    
    private func setupMainScrollView() {
        mainScrollView.delegate = self
        mainScrollView.isPagingEnabled = true
        mainScrollView.showsVerticalScrollIndicator = false
        mainScrollView.showsHorizontalScrollIndicator = false
        // コンテンツ幅 = ページ数 x ページ幅
        mainScrollView.contentSize = CGSize(
            width: calculateX(at: numberOfPages),
            height: mainScrollView.bounds.height
        )
    }
    
    private func generateSubScrollView(at page: Int) -> UIScrollView {
        let frame = calculateSubScrollViewFrame(at: page)
        let subScrollView = UIScrollView(frame: frame)
        
        subScrollView.delegate = self
        subScrollView.maximumZoomScale = 3.0
        subScrollView.minimumZoomScale = 1.0
        subScrollView.showsHorizontalScrollIndicator = false
        subScrollView.showsVerticalScrollIndicator = false
        
        // ダブルタップされたときのイベントハンドリングを設定
         let gesture = UITapGestureRecognizer(target: self, action: #selector(didDoubleTapSubScrollView(_:)))
        gesture.numberOfTapsRequired = 2
        subScrollView.addGestureRecognizer(gesture)
 
        
        return subScrollView
 
    }
    
    private func generateImageView(at page: Int) -> UIImageView {
        let frame = mainScrollView.bounds
        let imageView = UIImageView(frame: frame)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = image(at: page)
        
        return imageView
    }
    
    /// ページコントロールを操作された時
    @objc private func didValueChangePageControl() {
        currentPage = pageControl.currentPage
        let x = calculateX(at: currentPage)
        mainScrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
    
    /// サブスクロールビューがダブルタップされた時
    @objc private func didDoubleTapSubScrollView(_ gesture: UITapGestureRecognizer) {
        guard let subScrollView = gesture.view as? UIScrollView else { return }
        
        if subScrollView.zoomScale < subScrollView.maximumZoomScale {
            // タップされた場所を中心に拡大する
            let location = gesture.location(in: subScrollView)
            let rect = calculateRectForZoom(location: location, scale: subScrollView.maximumZoomScale)
            subScrollView.zoom(to: rect, animated: true)
        } else {
            subScrollView.setZoomScale(subScrollView.minimumZoomScale, animated: true)
        }
    }
    
    /// ページ幅 x position でX位置を計算
    private func calculateX(at position: Int) -> CGFloat {
        return mainScrollView.bounds.width * CGFloat(position)
    }
    
    /// スクロールビューのオフセット位置からページインデックスを計算
    private func calculatePage(of scrollView: UIScrollView) -> Int {
        let width = scrollView.bounds.width
        let offsetX = scrollView.contentOffset.x
        let position = (offsetX - (width / 2)) / width
        return Int(floor(position) + 1)
    }
    
    /// タップされた位置と拡大率から拡大後のCGRectを計算する
    private func calculateRectForZoom(location: CGPoint, scale: CGFloat) -> CGRect {
        let size = CGSize(
            width: mainScrollView.bounds.width / scale,
            height: mainScrollView.bounds.height / scale
        )
        let origin = CGPoint(
            x: location.x - size.width / 2,
            y: location.y - size.height / 2
        )
        return CGRect(origin: origin, size: size)
    }
    
    /// サブスクロールビューのframeを計算
    private func calculateSubScrollViewFrame(at page: Int) -> CGRect {
        var frame = mainScrollView.bounds
        frame.origin.x = calculateX(at: page)
        return frame
    }
    
    private func resetZoomScaleOfSubScrollViews(without exclusionSubScrollView: UIScrollView) {
        for subview in mainScrollView.subviews {
            guard
                let subScrollView = subview as? UIScrollView,
                subScrollView != exclusionSubScrollView
                else {
                    continue
            }
            subScrollView.setZoomScale(subScrollView.minimumZoomScale, animated: false)
        }
    }
    
    private func image(at page: Int) -> UIImage? {
        return UIImage(named: "\(page)")
    }
}

extension ContainerViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView != mainScrollView { return }
        
        let page = calculatePage(of: scrollView)
        if page == currentPage { return }
        currentPage = page
        
        pageControl.currentPage = page
        
        // 他のすべてのサブスクロールビューの拡大率をリセット
        resetZoomScaleOfSubScrollViews(without: scrollView)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scrollView.subviews.first as? UIImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        guard let imageView = scrollView.subviews.first as? UIImageView else { return }
        
        scrollView.contentInset = UIEdgeInsets(
            top: max((scrollView.frame.height - imageView.frame.height) / 2, 0),
            left: max((scrollView.frame.width - imageView.frame.width) / 2, 0),
            bottom: 0,
            right: 0
        )
    }
 
    
    
}
