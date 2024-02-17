////
//  WeekCalendarUIView.swift
//  bug-free-goggles
//
//  Created by Mac on 14/05/23.
//

import SwiftUI

struct WeekCalendarUIView: UIViewRepresentable {
    var bounds: CGSize
    var selectedDate: Date
    
    func makeUIView(context: Context) -> MyCalendarUIView {
        let calendarView = MyCalendarUIView(frame: CGRect(origin: .zero, size: bounds))
        calendarView.selectedDate = selectedDate
        return calendarView
    }
    
    func updateUIView(_ uiView: MyCalendarUIView, context: Context) {
        uiView.updateSelectedDate()
    }
    
    typealias UIViewType = MyCalendarUIView
}

class MyCalendarUIView: UIView {
    let collectionView: UICollectionView
    var layout = UICollectionViewFlowLayout()
    var maxDate: Date = Date().endOfWeek
    var minDate: Date = Date().startOfYear.startOfWeek
    
    var isFromDateUpdate: Bool = false
    var previousDate: Date = CalendarManager.shared.previousDate
    var selectedDate: Date = CalendarManager.shared.selectedDate
    
    var previousPage: CGFloat = 0
    
    var numberOfCells: Int {
        Date.dates(from: minDate, to: maxDate).count
    }
    
    override init(frame: CGRect) {
        layout.scrollDirection = .horizontal
        let spacing: CGFloat = 0
        let cellSize = (frame.size.width / 7) - spacing
        layout.itemSize = CGSize(width: cellSize, height: frame.size.height)
        layout.minimumLineSpacing = spacing
        self.collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        super.init(frame: frame)
        
        self.collectionView.alpha = 0
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(MyCalendarCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView.isPagingEnabled = true
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.backgroundColor = .clear
        self.addSubview(collectionView)
        
        self.selectedDate = CalendarManager.shared.selectedDate
        self.scrollToSelectedDate(animate: true)
        
        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { [weak self] notification in
            self?.reloadCalendarDates()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCalendar), name: .init("ReloadWeekCalendar"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(scrollCalendarToToday), name: .init("WeekCalendarScrollToToday"), object: nil)
                
        UIView.animate(withDuration: 0.7) {
            self.collectionView.alpha = 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let pageWidth = self.collectionView.frame.size.width
            self.previousPage = ((self.collectionView.contentOffset.x) / pageWidth) + 1
        }
    }
        
    @objc func reloadCalendarDates() {
        if maxDate != Date().endOfWeek {
            maxDate = Date().endOfWeek
            minDate = Date().startOfYear.adjust(.year, offset: -5).startOfWeek
        }
    }
    
    @objc func reloadCalendar(notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            if let shouldScroll = notification.object as? Bool {
                if shouldScroll {
                    self?.scrollToSelectedDate(animate: false)
                }
            } else {
                self?.scrollToSelectedDate(animate: false)
            }
        }
    }
    
    @objc func scrollCalendarToToday(notification: Notification) {
        let animate = notification.object as? Bool ?? false
        self.scrollToToday(animate: animate)
    }
    
    @objc func refreshHomeCalendarForActivityDatasets(notification: Notification) {
        collectionView.reloadData()
    }
    
    func updateSelectedDate() {
        selectedDate = CalendarManager.shared.selectedDate
        
        if CalendarManager.shared.previousDate < CalendarManager.shared.selectedDate.startOfWeek && abs(CalendarManager.shared.previousDate.dayDifference(from: CalendarManager.shared.selectedDate)) == 1 {
            isFromDateUpdate = true
            scrollToSelectedDate(animate: true)
            
        } else if CalendarManager.shared.previousDate > CalendarManager.shared.selectedDate.endOfWeek && abs(CalendarManager.shared.previousDate.dayDifference(from: CalendarManager.shared.selectedDate)) == 1 {
            isFromDateUpdate = true
            scrollToSelectedDate(animate: true)
        }
        CalendarManager.shared.previousDate = CalendarManager.shared.selectedDate
        collectionView.reloadData()
    }
    
    private func scrollToSelectedDate(animate: Bool) {
        let dateDiff = selectedDate.startOfWeek.dayDifference(from: minDate)
        collectionView.scrollToItemIfAvailable(at: IndexPath(item: dateDiff, section: 0), at: .left, animated: animate)
    }
    
    private func scrollToToday(animate: Bool) {
        collectionView.scrollToItemIfAvailable(at: IndexPath(item: numberOfCells - 1, section: 0), at: .right, animated: animate)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyCalendarUIView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var calendarCell: UICollectionViewCell
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MyCalendarCell {
            let date = date(for: indexPath.item)
            self.configureCell(cell: cell, date: date, indexPath: indexPath)
            calendarCell = cell
        } else {
            calendarCell = MyCalendarCell()
        }
        
        return calendarCell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell  = cell as? MyCalendarCell {
            let date = date(for: indexPath.item)
            self.configureCell(cell: cell, date: date, indexPath: indexPath)
        }
    }
    
    private func configureCell(cell: MyCalendarCell, date: Date, indexPath: IndexPath) {
        cell.backgroundColor = .clear
        cell.forceReloadView()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        
        cell.dateLabel.text = formatter.string(from: date)
        if CalendarManager.shared.selectedDate.startOfDay == date.startOfDay {
            cell.dateLabel.textColor = .white
        } else {
            cell.dateLabel.textColor = .black
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let date = date(for: indexPath.item)
        CalendarManager.shared.selectedDate = date.startOfDay
        collectionView.reloadData()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = collectionView.frame.size.width
        let currentPage = ((collectionView.contentOffset.x) / pageWidth) + 1
        
        if previousPage == currentPage {
            return
        }
        
        previousPage = currentPage
        
        let index = Int(ceil(currentPage))
        let date = currentDate(for: index)
        
        if date > selectedDate {
            // swipe right
            if date <= Date() {
                if selectedDate.adjust(.day, offset: 7) > Date() {
                    CalendarManager.shared.selectedDate = Date().startOfDay
                } else {
                    CalendarManager.shared.selectedDate = selectedDate.adjust(.day, offset: 7)
                }
            }
        } else if date < selectedDate {
            // swipe left
            CalendarManager.shared.selectedDate = selectedDate.adjust(.day, offset: -7)
        }
    }
    
    func date(for index: Int) -> Date {
        minDate.adjust(.day, offset: index)
    }
    
    func currentDate(for pageIndex: Int) -> Date {
        let dateIndex = (pageIndex - 1) * 7
        let date = date(for: dateIndex >= 0 ? dateIndex : 0)
        
        return date
    }
}

// MARK: Cell
class MyCalendarCell: UICollectionViewCell {
    
    var dateLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        addCellView()
    }
    
    func addCellView() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        dateLabel.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        dateLabel.textAlignment = .center
        dateLabel.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: bounds.size)
        self.addSubview(dateLabel)
    }
    
    func forceReloadView() {
        self.addCellView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UICollectionView {
    func isIndexPathAvailable(_ indexPath: IndexPath) -> Bool {
        guard dataSource != nil,
              indexPath.section < numberOfSections,
              indexPath.item < numberOfItems(inSection: indexPath.section) else {
            return false
        }

        return true
    }

    func scrollToItemIfAvailable(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition, animated: Bool) {
        guard isIndexPathAvailable(indexPath) else { return }
        
        self.isPagingEnabled = false
        scrollToItem(at: indexPath, at: scrollPosition, animated: animated)
        self.isPagingEnabled = true
    }
}

