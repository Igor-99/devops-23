



![Схемы  workflow](https://github.com/Igor-99/devops-23/assets/29104612/0e6678fe-f965-4a4b-a862-d756348ef6e6)

# Домашнее задание к занятию 7 «Жизненный цикл ПО»

## Подготовка к выполнению

1. Получить бесплатную версию [Jira](https://www.atlassian.com/ru/software/jira/free).
2. Настроить её для своей команды разработки.
3. Создать доски Kanban и Scrum.

## Основная часть

Необходимо создать собственные workflow для двух типов задач: bug и остальные типы задач. Задачи типа bug должны проходить жизненный цикл:

1. Open -> On reproduce.
2. On reproduce -> Open, Done reproduce.
3. Done reproduce -> On fix.
4. On fix -> On reproduce, Done fix.
5. Done fix -> On test.
6. On test -> On fix, Done.
7. Done -> Closed, Open.

![Схемы  workflow для bug](https://github.com/Igor-99/devops-23/assets/29104612/e9ecce61-cf39-42f5-909a-190db37c0e70)

Остальные задачи должны проходить по упрощённому workflow:

1. Open -> On develop.
2. On develop -> Open, Done develop.
3. Done develop -> On test.
4. On test -> On develop, Done.
5. Done -> Closed, Open.

![Схемы  workflow для всех](https://github.com/Igor-99/devops-23/assets/29104612/8d12fac4-ee3d-439e-90d7-fd576b989d53)

**Что нужно сделать**

1. Создайте задачу с типом bug, попытайтесь провести его по всему workflow до Done. 
![Задание 1](https://github.com/Igor-99/devops-23/assets/29104612/ef77f2e6-8dd2-49d0-b82a-fe2bd548872f)
1. Создайте задачу с типом epic, к ней привяжите несколько задач с типом task, проведите их по всему workflow до Done. 
Выглядит так же как и скрин выше
1. При проведении обеих задач по статусам используйте kanban. 
1. Верните задачи в статус Open.
1. Перейдите в Scrum, запланируйте новый спринт, состоящий из задач эпика и одного бага, стартуйте спринт, проведите задачи до состояния Closed. Закройте спринт.
все отлично отработало
![1](https://github.com/Igor-99/devops-23/assets/29104612/2a1daf04-6419-4b56-acba-838b31a34a91)
2. Если всё отработалось в рамках ожидания — выгрузите схемы workflow для импорта в XML. Файлы с workflow и скриншоты workflow приложите к решению задания.

```xml


<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE workflow PUBLIC "-//OpenSymphony Group//DTD OSWorkflow 2.8//EN" "http://www.opensymphony.com/osworkflow/workflow_2_8.dtd">
<workflow>
  <meta name="jira.description"></meta>
  <meta name="jira.update.author.id">6220dfb3c88f1000682f1945</meta>
  <meta name="jira.update.author.key">6220dfb3c88f1000682f1945</meta>
  <meta name="jira.updated.date">1687790535654</meta>
  <initial-actions>
    <action id="1" name="Create">
      <validators>
        <validator name="" type="class">
          <arg name="class.name">com.atlassian.jira.workflow.validator.PermissionValidator</arg>
          <arg name="permission">Create Issue</arg>
        </validator>
      </validators>
      <results>
        <unconditional-result old-status="null" status="open" step="1">
          <post-functions>
            <function type="class">
              <arg name="class.name">com.atlassian.jira.workflow.function.issue.IssueCreateFunction</arg>
            </function>
            <function type="class">
              <arg name="class.name">com.atlassian.jira.workflow.function.issue.IssueReindexFunction</arg>
            </function>
            <function type="class">
              <arg name="class.name">com.atlassian.jira.workflow.function.event.FireIssueEventFunction</arg>
              <arg name="eventTypeId">1</arg>
            </function>
          </post-functions>
        </unconditional-result>
      </results>
    </action>
  </initial-actions>
  <steps>
    <step id="1" name="Open">
      <meta name="jira.status.id">1</meta>
      <actions>
        <action id="11" name="reproduce">
          <meta name="jira.description"></meta>
          <meta name="jira.fieldscreen.id"></meta>
          <results>
            <unconditional-result old-status="null" status="null" step="2">
              <post-functions>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.UpdateIssueStatusFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.misc.CreateCommentFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.GenerateChangeHistoryFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.IssueReindexFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.event.FireIssueEventFunction</arg>
                  <arg name="eventTypeId">13</arg>
                </function>
              </post-functions>
            </unconditional-result>
          </results>
        </action>
      </actions>
    </step>
    <step id="2" name="On reproduce">
      <meta name="jira.status.id">10006</meta>
      <actions>
        <action id="21" name="reproduce">
          <meta name="jira.description"></meta>
          <meta name="jira.fieldscreen.id"></meta>
          <results>
            <unconditional-result old-status="null" status="null" step="3">
              <post-functions>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.UpdateIssueStatusFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.misc.CreateCommentFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.GenerateChangeHistoryFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.IssueReindexFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.event.FireIssueEventFunction</arg>
                  <arg name="eventTypeId">13</arg>
                </function>
              </post-functions>
            </unconditional-result>
          </results>
        </action>
        <action id="111" name="open">
          <meta name="jira.description"></meta>
          <meta name="jira.fieldscreen.id"></meta>
          <results>
            <unconditional-result old-status="null" status="null" step="1">
              <post-functions>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.UpdateIssueStatusFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.misc.CreateCommentFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.GenerateChangeHistoryFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.IssueReindexFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.event.FireIssueEventFunction</arg>
                  <arg name="eventTypeId">13</arg>
                </function>
              </post-functions>
            </unconditional-result>
          </results>
        </action>
      </actions>
    </step>
    <step id="3" name="Done reproduce">
      <meta name="jira.status.id">10007</meta>
      <actions>
        <action id="31" name="fix">
          <meta name="jira.description"></meta>
          <meta name="jira.fieldscreen.id"></meta>
          <results>
            <unconditional-result old-status="null" status="null" step="4">
              <post-functions>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.UpdateIssueStatusFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.misc.CreateCommentFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.GenerateChangeHistoryFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.IssueReindexFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.event.FireIssueEventFunction</arg>
                  <arg name="eventTypeId">13</arg>
                </function>
              </post-functions>
            </unconditional-result>
          </results>
        </action>
      </actions>
    </step>
    <step id="4" name="On fix">
      <meta name="jira.status.id">10008</meta>
      <actions>
        <action id="41" name="fix">
          <meta name="jira.description"></meta>
          <meta name="jira.fieldscreen.id"></meta>
          <results>
            <unconditional-result old-status="null" status="null" step="5">
              <post-functions>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.UpdateIssueStatusFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.misc.CreateCommentFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.GenerateChangeHistoryFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.IssueReindexFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.event.FireIssueEventFunction</arg>
                  <arg name="eventTypeId">13</arg>
                </function>
              </post-functions>
            </unconditional-result>
          </results>
        </action>
        <action id="101" name="reproduce">
          <meta name="jira.description"></meta>
          <meta name="jira.fieldscreen.id"></meta>
          <results>
            <unconditional-result old-status="null" status="null" step="2">
              <post-functions>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.UpdateIssueStatusFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.misc.CreateCommentFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.GenerateChangeHistoryFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.IssueReindexFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.event.FireIssueEventFunction</arg>
                  <arg name="eventTypeId">13</arg>
                </function>
              </post-functions>
            </unconditional-result>
          </results>
        </action>
      </actions>
    </step>
    <step id="5" name="Done fix">
      <meta name="jira.status.id">10009</meta>
      <actions>
        <action id="51" name="test">
          <meta name="jira.description"></meta>
          <meta name="jira.fieldscreen.id"></meta>
          <results>
            <unconditional-result old-status="null" status="null" step="6">
              <post-functions>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.UpdateIssueStatusFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.misc.CreateCommentFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.GenerateChangeHistoryFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.IssueReindexFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.event.FireIssueEventFunction</arg>
                  <arg name="eventTypeId">13</arg>
                </function>
              </post-functions>
            </unconditional-result>
          </results>
        </action>
      </actions>
    </step>
    <step id="6" name="On test">
      <meta name="jira.status.id">10010</meta>
      <actions>
        <action id="61" name="done">
          <meta name="jira.description"></meta>
          <meta name="jira.fieldscreen.id"></meta>
          <results>
            <unconditional-result old-status="null" status="null" step="7">
              <post-functions>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.UpdateIssueStatusFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.misc.CreateCommentFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.GenerateChangeHistoryFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.IssueReindexFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.event.FireIssueEventFunction</arg>
                  <arg name="eventTypeId">13</arg>
                </function>
              </post-functions>
            </unconditional-result>
          </results>
        </action>
        <action id="91" name="fix">
          <meta name="jira.description"></meta>
          <meta name="jira.fieldscreen.id"></meta>
          <results>
            <unconditional-result old-status="null" status="null" step="4">
              <post-functions>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.UpdateIssueStatusFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.misc.CreateCommentFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.GenerateChangeHistoryFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.IssueReindexFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.event.FireIssueEventFunction</arg>
                  <arg name="eventTypeId">13</arg>
                </function>
              </post-functions>
            </unconditional-result>
          </results>
        </action>
      </actions>
    </step>
    <step id="7" name="Done">
      <meta name="jira.status.id">10005</meta>
      <actions>
        <action id="71" name="close">
          <meta name="jira.description"></meta>
          <meta name="jira.fieldscreen.id"></meta>
          <results>
            <unconditional-result old-status="null" status="null" step="8">
              <post-functions>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.UpdateIssueStatusFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.misc.CreateCommentFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.GenerateChangeHistoryFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.IssueReindexFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.event.FireIssueEventFunction</arg>
                  <arg name="eventTypeId">13</arg>
                </function>
              </post-functions>
            </unconditional-result>
          </results>
        </action>
        <action id="81" name="open">
          <meta name="jira.description"></meta>
          <meta name="jira.fieldscreen.id"></meta>
          <results>
            <unconditional-result old-status="null" status="null" step="1">
              <post-functions>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.UpdateIssueStatusFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.misc.CreateCommentFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.GenerateChangeHistoryFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.issue.IssueReindexFunction</arg>
                </function>
                <function type="class">
                  <arg name="class.name">com.atlassian.jira.workflow.function.event.FireIssueEventFunction</arg>
                  <arg name="eventTypeId">13</arg>
                </function>
              </post-functions>
            </unconditional-result>
          </results>
        </action>
      </actions>
    </step>
    <step id="8" name="Closed">
      <meta name="jira.status.id">6</meta>
    </step>
  </steps>
</workflow>

```
---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
