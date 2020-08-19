//
//  ResultsVCViewController.swift
//  Boost ctRL
//
//  Created by Zac Johnson on 8/28/19.
//  Copyright © 2019 Zac Johnson. All rights reserved.
//

import UIKit
import Firebase

class ResultsVC: UIViewController {
	
	// MARK: Class Variables
	
	let cellID = "cellID"
	
	var match: Match?
	var winThreshold: Int?
	//var results = [String]()
	var results: [String] = [String]()
	
	
	// MARK: - UI Elements
	
	var teamOneLogo: UIImage?
	var teamTwoLogo: UIImage?
	
	var teamOneScoreLabel: UILabel = {
		let label = UILabel()
		label.usesAutoLayout()
		label.textAlignment = .center
		label.textColor = ctRLTheme.cloudWhite
		
		return label
	}()
	
	let teamTwoScoreLabel: UILabel = {
		let label = UILabel()
		label.usesAutoLayout()
		label.textAlignment = .center
		label.textColor = ctRLTheme.cloudWhite
		
		return label
	}()
	
	let spacerLabel: UILabel = {
		let label = UILabel()
		label.usesAutoLayout()
		label.font = .systemFont(ofSize: 20, weight: .regular)
		label.text = "-"
		label.textAlignment = .center
		label.textColor = ctRLTheme.cloudWhite
		label.frame.size = .init(width: 6, height: 6)
		
		return label
	}()
	
	lazy var teamOneImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.usesAutoLayout()
		imageView.contentMode = .scaleAspectFit

		if let logo = teamOneLogo {
			imageView.image = logo
		} else {
			imageView.image = #imageLiteral(resourceName: "logo-null")
		}
		
		return imageView
	}()
	
	lazy var teamTwoImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.usesAutoLayout()
		if let logo = teamTwoLogo {
			imageView.image = logo
		} else {
			imageView.image = #imageLiteral(resourceName: "logo-null")
		}
		imageView.contentMode = .scaleAspectFit
		
		return imageView
	}()
	
	let leftContainer: UIView = {
		let view = UIView()
		view.usesAutoLayout()
		
		return view
	}()
	
	let rightContainer: UIView = {
		let view = UIView()
		view.usesAutoLayout()
		
		return view
	}()
	
	var headerView: UIView = {
		var header = UIView()
		header.usesAutoLayout()
		header.backgroundColor = ctRLTheme.darkBlue
		
		return header
	}()
	
	var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .plain)
		tableView.usesAutoLayout()
		tableView.backgroundView?.backgroundColor = ctRLTheme.midnightBlue
		tableView.allowsSelection = false
		tableView.separatorStyle = .singleLine
		tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		//tableView.isHidden = true
		
		return tableView
	}()
	
	 
	
	// MARK: - View Lifecycle

    override func viewDidLoad() {
		super.viewDidLoad()
        // Do any additional setup after loading the view.
		tableView.delegate = self
		tableView.dataSource = self
		
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
		
		configureMainView()
		layoutHeaderViews()
		configureHeaderLabels()
		
		if let matchID = match?.id {
			getGameResults(forMatch: matchID) {
				self.tableView.reloadData()
				self.tableView.isHidden = false
				
				self.configureHeaderLabels()
				print(self.results)
				print("Done downloading results!")
			}
		}
    }
	
	override func viewWillDisappear(_ animated: Bool) {
		match = nil
		results = []
	}
	
	
	// MARK: - View Setup
	
	/// Lays out the series score header view and table view
	func configureMainView() {
		view.backgroundColor = ctRLTheme.midnightBlue
		view.layer.cornerRadius = 16
		view.clipsToBounds = true
		
		view.addSubview(headerView)
		view.addSubview(tableView)
		
		headerView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
		headerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
		
		tableView.anchor(top: headerView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
		
		removeEmptySpaceUnderLastCell()
	}
	
	
	/// Removes white space under the last cell in a tableView. **Must** be called in `viewDidLoad`.
	func removeEmptySpaceUnderLastCell() {
		tableView.tableFooterView = UIView()
		tableView.backgroundColor = .clear
	}
	
	/// Lays out views inside of the series score header
	func layoutHeaderViews() {
		[leftContainer, rightContainer, spacerLabel, teamOneScoreLabel, teamTwoScoreLabel].forEach { headerView.addSubview($0) }
		
		// spacer label (dash in the middle)
		spacerLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
		spacerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
		
		// Score Labels
		teamOneScoreLabel.anchor(top: nil, leading: nil, bottom: nil, trailing: spacerLabel.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 8) )
		teamOneScoreLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
		
		
		teamTwoScoreLabel.anchor(top: nil, leading: spacerLabel.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 8, bottom: 0, right: 0))
		teamTwoScoreLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
		
		// Logos
		leftContainer.anchor(top: headerView.topAnchor, leading: headerView.leadingAnchor, bottom: headerView.bottomAnchor, trailing: headerView.centerXAnchor)
		rightContainer.anchor(top: headerView.topAnchor, leading: headerView.centerXAnchor, bottom: headerView.bottomAnchor, trailing: headerView.trailingAnchor)
		
		leftContainer.addSubview(teamOneImageView)
		
		teamOneImageView.translatesAutoresizingMaskIntoConstraints = false
		teamOneImageView.centerXAnchor.constraint(equalTo: leftContainer.centerXAnchor).isActive = true
		teamOneImageView.centerYAnchor.constraint(equalTo: leftContainer.centerYAnchor).isActive = true
		teamOneImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
		teamOneImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true

		rightContainer.addSubview(teamTwoImageView)
		
		teamTwoImageView.translatesAutoresizingMaskIntoConstraints = false
		teamTwoImageView.centerXAnchor.constraint(equalTo: rightContainer.centerXAnchor).isActive = true
		teamTwoImageView.centerYAnchor.constraint(equalTo: rightContainer.centerYAnchor).isActive = true
		teamTwoImageView.anchorSize(to: teamOneImageView)
	}
	
	/// Configure labels displaying the series score.
	///
	/// Winning team is bolded.
	func configureHeaderLabels() {
		teamOneScoreLabel.text = match?.oneScore ?? "0"
		teamTwoScoreLabel.text = match?.twoScore ?? "0"
		
		teamOneScoreLabel.font = AvenirNext.ultraLight.size(45)
		teamTwoScoreLabel.font = AvenirNext.ultraLight.size(45)

		if let oneScore = Int(match?.oneScore ?? "0"), let twoScore = Int(match?.twoScore ?? "0"), let winThreshold = winThreshold {
			let finished = oneScore == winThreshold || twoScore == winThreshold
			if finished {
				if oneScore > twoScore {
					teamOneScoreLabel.font = AvenirNext.regular.size(45)
				} else {
					teamTwoScoreLabel.font = AvenirNext.regular.size(45)
				}
			}
		}
		
	}
	
	
	// MARK: - Networking
	
	/// Download game results from Firebase
	///
	/// - Parameters:
	///   - matchID: id for the match
	///   - completion: stop loading animation
	private func getGameResults(forMatch matchID: String, completion: @escaping () -> Void) {
		let resultsDB = Database.database().reference().child("results").child(matchID)
		
		resultsDB.observe(.childAdded) { (snapshot) in
			print(snapshot.value)
			
			if snapshot.key == "max" {
				if let maxWins = snapshot.value as? Int {
					self.winThreshold = maxWins
				} else {
					self.winThreshold = 4
				}
			} else {
				if let result = snapshot.value as? String {
					self.results.append(result)
				}
			}
			
			completion()
		}
		
	}
	
	private func logAnaylyticsEvent() {
		guard let match = match else { return }
		
		let params = [
			EventParameter.matchID : match.id,
			EventParameter.teamOneID : match.teamOneID,
			EventParameter.teamTwoID : match.teamTwoID
		]
	
		Analytics.logEvent(EventType.results, parameters: params)
	}
}



// MARK: TableView Data Source + Delegate Methods
extension ResultsVC: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 50
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if results.isEmpty {
			return 1
		}
	
		return results.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
		cell.backgroundColor = ctRLTheme.midnightBlue
		
		guard !results.isEmpty else {
			cell.textLabel?.text = "Match data coming soon"
			cell.textLabel?.textAlignment = .center
			cell.textLabel?.font = AvenirNext.regular.size(20)
			cell.textLabel?.textColor = ctRLTheme.cloudWhite
			return cell
		}
		
		cell.textLabel?.text = ""
		
		var result = results[indexPath.row]
		let wentToOvertime = result.contains("*")
		
		if wentToOvertime {
			result = String(result.dropLast())
			
			let overtimeLabel: UILabel = {
				let label = UILabel()
				label.usesAutoLayout()
				label.text = "(OT)"
				label.textColor = ctRLTheme.hotPink
				label.font = AvenirNext.regular.size(14)
				
				return label
			}()
			
			cell.contentView.addSubview(overtimeLabel)
			
			overtimeLabel.center(in: cell.contentView)
		}
		
		let parsedResult = result.components(separatedBy: "-")
		
		let leftScoreContainer = UIView()
		leftScoreContainer.usesAutoLayout()
		let rightScoreContainer = UIView()
		rightScoreContainer.usesAutoLayout()
		
		[leftScoreContainer, rightScoreContainer].forEach {
			cell.contentView.addSubview($0)
		}
		
		leftScoreContainer.anchor(top: cell.contentView.topAnchor, leading: cell.contentView.leadingAnchor, bottom: cell.contentView.bottomAnchor, trailing: cell.contentView.centerXAnchor)
		rightScoreContainer.anchor(top: cell.contentView.topAnchor, leading: cell.contentView.centerXAnchor, bottom: cell.contentView.bottomAnchor, trailing: cell.contentView.trailingAnchor)
		
		// MARK: Team One Score Label
		let leftScoreLabel: UILabel = {
			let label = UILabel()
			label.usesAutoLayout()
			label.textAlignment = .center
			label.text = parsedResult.first ?? "-"
			label.font = AvenirNext.regular.size(20)
			label.textColor = ctRLTheme.cloudWhite
			return label
		}()
		
		leftScoreContainer.addSubview(leftScoreLabel)
		leftScoreLabel.centerXAnchor.constraint(equalTo: leftScoreContainer.centerXAnchor).isActive = true
		leftScoreLabel.centerYAnchor.constraint(equalTo: leftScoreContainer.centerYAnchor).isActive = true
		leftScoreLabel.heightAnchor.constraint(equalTo: cell.contentView.heightAnchor).isActive = true
		leftScoreLabel.widthAnchor.constraint(equalTo: cell.contentView.heightAnchor).isActive = true
		
		// MARK: Team Two Score Label
		let rightScoreLabel: UILabel = {
			let label = UILabel()
			label.usesAutoLayout()
			label.textAlignment = .center
			label.text = parsedResult.last ?? "-"
			label.font = AvenirNext.regular.size(20)
			label.textColor = ctRLTheme.cloudWhite
			return label
		}()
		
		rightScoreContainer.addSubview(rightScoreLabel)
		rightScoreLabel.centerXAnchor.constraint(equalTo: rightScoreContainer.centerXAnchor).isActive = true
		rightScoreLabel.centerYAnchor.constraint(equalTo: rightScoreContainer.centerYAnchor).isActive = true
		rightScoreLabel.anchorSize(to: leftScoreLabel)
		
		
		// MARK: Winners Label
		if let leftScore = parsedResult.first, let rightScore = parsedResult.last {
			let leftWon = leftScore > rightScore
			
			let winnersLabel: UILabel = {
				let label = UILabel()
				label.usesAutoLayout()
				label.text = "✅"
				label.font = AvenirNext.regular.size(20)
				return label
			}()
			
			if leftWon {
				leftScoreContainer.addSubview(winnersLabel)
				winnersLabel.anchor(top: nil, leading: nil, bottom: nil, trailing: leftScoreLabel.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 8))
				winnersLabel.centerYAnchor.constraint(equalTo: leftScoreContainer.centerYAnchor).isActive = true
			} else {
				rightScoreContainer.addSubview(winnersLabel)
				winnersLabel.anchor(top: nil, leading: rightScoreLabel.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 8, bottom: 0, right: 0))
				winnersLabel.centerYAnchor.constraint(equalTo: rightScoreContainer.centerYAnchor).isActive = true
			}
		}
		
		return cell
	}

}
