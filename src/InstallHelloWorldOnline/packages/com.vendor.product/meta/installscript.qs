/**************************************************************************
**
** Copyright (C) 2013 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the Qt Installer Framework.
**
** $QT_BEGIN_LICENSE:LGPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Digia.  For licensing terms and
** conditions see http://qt.digia.com/licensing.  For further information
** use the contact form at http://qt.digia.com/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Digia gives you certain additional
** rights.  These rights are described in the Digia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3.0 as published by the Free Software
** Foundation and appearing in the file LICENSE.GPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU General Public License version 3.0 requirements will be
** met: http://www.gnu.org/copyleft/gpl.html.
**
**
** $QT_END_LICENSE$
**
**************************************************************************/

//コンストラクタ
function Component()
{
  //完了ページにレイアウトを追加
  if(installer.isInstaller()){                                       // [1]
    installer.addWizardPageItem(component
　　　　　　　　　　　　　　　, "FinishAndOpenForm"
　　　　　　　　　　　　　　　, QInstaller.InstallationFinished)      // [2]
  }
  //インストールが完了したときのイベント（つまり完了確認ページが表示されたときのイベント）
  installer.installationFinished.connect(this
                              , Component.prototype.installationFinishedPageIsShown);  // [3]
  //完了ボタンが押されたときのシグナル
  installer.finishButtonClicked.connect(this
                              , Component.prototype.installationFinished)  // [4]

}

//コンポーネント選択のデフォルト確認
Component.prototype.isDefault = function()
{
  return true
}

//インストール動作を追加
Component.prototype.createOperations = function()
{
  try{
    // createOperationsの基本処理を実行
    component.createOperations()

    if(installer.value("os") === "win"){
      //Readme.txt用のショートカット
      component.addOperation("CreateShortcut"
　　　　　　　　　　　　　　, "@TargetDir@/README.txt"
　　　　　　　　　　　　　　, "@StartMenuDir@/README.lnk"
　　　　　　　　　　　　　　, "workingDirectory=@TargetDir@"
　　　　　　　　　　　　　　, "iconPath=%SystemRoot%/system32/SHELL32.dll"
　　　　　　　　　　　　　　, "iconId=2")
      //実行ファイル用のショートカット
      component.addOperation("CreateShortcut"
　　　　　　　　　　　　　　, "@TargetDir@/HelloWorld.exe"
　　　　　　　　　　　　　　, "@StartMenuDir@/HelloWorld.lnk"
　　　　　　　　　　　　　　, "workingDirectory=@TargetDir@"
　　　　　　　　　　　　　　, "iconPath=@TargetDir@/HelloWorld.exe"
　　　　　　　　　　　　　　, "iconId=0")
    }
  }catch(e){
    print(e)
  }
}

//インストールが完了したときのシグナルハンドラ
Component.prototype.installationFinishedPageIsShown = function ()
{
  try{
    if(installer.isInstaller() && installer.status !== QInstaller.Success){
      //追加したレイアウトのオブジェクト取得
      var form = component.userInterface("FinishAndOpenForm")                      // [5]
      //失敗したので追加した部分全体を非表示
      form.visible = false
    }
  }catch(e){
    print(e)
  }
}

//完了ボタンが押されたときのシグナルハンドラ
Component.prototype.installationFinished = function ()
{
  try{
    if(installer.isInstaller() && installer.status === QInstaller.Success){        // [6]
      //追加したレイアウトのオブジェクト取得
      var form = component.userInterface("FinishAndOpenForm")
      //チェック状態を確認
      if(form.openReadmeCheckBox.checked){                                         // [7]
        //実行
        QDesktopServices.openUrl("file:///"
                                 + installer.value("TargetDir") + "/README.txt")   // [8]
      }
      if(form.runAppCheckBox.checked){
        QDesktopServices.openUrl("file:///"
                                 + installer.value("TargetDir") + "/HelloWorld.exe")
      }
    }
  }catch(e){
    print(e)
  }
}

