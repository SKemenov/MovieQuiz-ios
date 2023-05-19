//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Sergey Kemenov on 18.05.2023.
//

import Foundation

/* Структура AlertModel должна содержать:
done - текст заголовка алерта title
done - текст сообщения алерта message
done - текст для кнопки алерта buttonText
??? - замыкание без параметров для действия по кнопке алерта completion
*/

// MARK: - Structs
//
//
/// A structure to collect information for the 'AlertPresenter' and show the final alert with game's score.
struct AlertModel {
    //  MARK: - Properties
    //
    //
    let title: String
    let text: String
    let buttonText: String
    let completion (() -> Void)
  
}

