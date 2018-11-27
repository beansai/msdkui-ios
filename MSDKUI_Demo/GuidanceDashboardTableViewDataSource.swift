//
// Copyright (C) 2017-2018 HERE Europe B.V.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import UIKit

final class GuidanceDashboardTableViewDataSource: NSObject {

    // MARK: - Types

    enum Item {
        case about
        case settings

        // MARK: - Properties

        var title: String {
            switch self {
            case .about:
                return "msdkui_app_about".localized
            case .settings:
                return "msdkui_app_settings".localized
            }
        }

        var icon: UIImage? {
            switch self {
            case .about:
                return UIImage(named: "Info")
            case .settings:
                return UIImage(named: "IconButton.options")
            }
        }
    }

    // MARK: - Properties

    private let items: [Item] = [.settings, .about]

    // MARK: - Public

    /// Returns the item at `IndexPath`.
    ///
    /// - Parameter indexPath: The table view index path.
    /// - Returns: The item at index path.
    func item(at indexPath: IndexPath) -> Item? {
        guard 0..<items.count ~= indexPath.row else {
            return nil
        }

        return items[indexPath.row]
    }
}

// MARK: - UITableViewDataSource

extension GuidanceDashboardTableViewDataSource: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            case let cellIdentifier = String(describing: GuidanceDashboardTableViewCell.self),
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? GuidanceDashboardTableViewCell,
            let item = item(at: indexPath)
            else {
                fatalError("Failed to dequeue GuidanceDashboardTableViewCell")
        }

        cell.configure(with: GuidanceDashboardTableViewCell.ViewModel(image: item.icon, title: item.title))

        return cell
    }
}
