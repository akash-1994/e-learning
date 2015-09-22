package controller;

public class Content {

	public Content(String tutContent, String tutName) {
		this.settutorialContent(tutContent);
		this.settutorialName(tutName);
	}

	public Content() {

	}

	private String tutContent;
	private String tutName;

	public void settutorialContent(String tutContent) {
		this.tutContent = tutContent;
	}

	public String gettutorialContent() {
		return tutContent;
	}

	public void settutorialName(String tutName) {
		this.tutName = tutName;
	}

	public String gettutorialName() {
		return tutName;
	}

}